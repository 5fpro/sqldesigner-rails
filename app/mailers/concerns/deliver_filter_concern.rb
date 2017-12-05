module DeliverFilterConcern
  protected

  def mail(headers = {}, *args)
    headers = headers.with_indifferent_access
    convert_headers_subject!(headers)
    convert_headers_target!(headers)
    super(headers, *args)
  end

  def convert_headers_subject!(headers)
    headers[:subject] = headers[:subject] + " | original to: #{headers[:to]}" if has_white_list?
    subject_prefixing!(headers)
  end

  def subject_prefixing!(headers)
    headers[:subject] = "[#{Rails.env}] #{headers[:subject]}" unless Rails.env.production?
  end

  def convert_headers_target!(headers)
    if has_white_list?
      headers[:to] = white_list_emails.select { |email| email == headers[:to] }
      headers[:to] << white_list_emails[0] if headers[:to].empty?
    end
    unless logged_emails.empty?
      headers[:to] = [headers[:to]] unless headers[:to].is_a?(Array)
      headers[:to] += logged_emails
    end
    headers[:to].uniq! if headers[:to].is_a?(Array)
  end

  def white_list_emails
    @white_list_emails ||= (ENV['WHITE_LIST_EMAILS'] || '').split(',').map { |email| email.delete(' ') }.select(&:present?)
  end

  def logged_emails
    @logged_emails ||= (ENV['LOGGED_EMAILS'] || '').split(',').map { |email| email.delete(' ') }.select(&:present?)
  end

  def has_white_list?
    !white_list_emails.empty?
  end
end
