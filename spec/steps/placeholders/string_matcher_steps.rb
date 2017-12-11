placeholder :string_matcher do
  match /包含/ do
    'expect(str).to include(value)'
  end

  match /不含/ do
    'expect(str).not_to include(value)'
  end

  match /有值/ do
    'expect(str).to be_present'
  end

  match /為空/ do
    'expect(str).to be_blank'
  end

  match /符合/ do
    'expect(str).to match(Regexp.new(regexp))'
  end

  match /不符/ do
    'expect(str).not_to match(Regexp.new(regexp))'
  end
end
