def match_by_hash(expected, got)
  if expected.is_a?(Hash) && expected != {}
    unless got.is_a?(Hash)
      puts "DEBUG:\n  expect: #{expected.inspect}\n  got: #{got.inspect}"
      expect(got).to be_a_kind_of(Hash)
    end
    expected.each_key { |k| match_by_hash(expected[k], got[k]) }
  elsif expected.is_a?(Array)
    expected.each_with_index { |v, i| match_by_hash(v, got[i]) }
  elsif expected.is_a?(Regexp)
    expect(got).to match(expected)
  elsif expected.is_a?(Class)
    expect(got).to be_a_kind_of(expected)
  else
    expect(got).to eq(expected)
  end
end

step '回應內容符合' do |body|
  matcher_rules = eval(body)
  match_by_hash(matcher_rules, JSON.parse(response.body).with_indifferent_access)
end
