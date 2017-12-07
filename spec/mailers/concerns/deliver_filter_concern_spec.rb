require 'rails_helper'

describe DeliverFilterConcern, type: :mailer do
  class ExampleMailer < ActionMailer::Base
    include DeliverFilterConcern

    def notify
      mail(to: 'haha@5fpro.com', subject: 'Haha', body: 'QQ')
    end
  end

  def set_white_list(emails)
    ENV['WHITE_LIST_EMAILS'] = emails
  end

  def set_logged(emails)
    ENV['LOGGED_EMAILS'] = emails
  end

  def mail
    ExampleMailer.notify
  end

  before do
    set_white_list ''
    set_logged ''
  end

  it 'blank, nil, #subject_prefixing!' do
    expect(mail.to).to eq(['haha@5fpro.com'])
    expect(mail.subject).to eq('[test] Haha')
    set_white_list nil
    set_logged nil
    expect(mail.to).to eq(['haha@5fpro.com'])
    expect(mail.subject).to eq('[test] Haha')
  end

  it 'white list only' do
    set_white_list 'hoho@5fpro.com, hey@5fpro.com'
    expect(mail.to).to eq(['hoho@5fpro.com'])
    set_white_list 'hoho@5fpro.com, haha@5fpro.com'
    expect(mail.to).to eq(['haha@5fpro.com'])
    set_white_list 'hoho@5fpro.com,haha@5fpro.com'
    expect(mail.to).to eq(['haha@5fpro.com'])
  end

  it 'logged only' do
    set_logged 'hoho@5fpro.com, hey@5fpro.com'
    expect(mail.to).to be_include('haha@5fpro.com').and be_include('hey@5fpro.com').and be_include('hoho@5fpro.com')
    set_logged 'hoho@5fpro.com,hey@5fpro.com'
    expect(mail.to).to be_include('haha@5fpro.com').and be_include('hey@5fpro.com').and be_include('hoho@5fpro.com')
    set_logged 'haha@5fpro.com'
    expect(mail.to).to be_include('haha@5fpro.com')
    expect(mail.to).not_to be_include('hey@5fpro.com')
    expect(mail.to).not_to be_include('hoho@5fpro.com')
  end

  it 'both white list and logged' do
    set_logged 'hoho@5fpro.com'
    set_white_list 'hey@5fpro.com'
    expect(mail.to).to be_include('hey@5fpro.com').and be_include('hoho@5fpro.com')
    expect(mail.to).not_to be_include('haha@5fpro.com')
  end
end
