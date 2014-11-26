describe Book do

  it 'should be valid' do
    book = Book.new(title: 'Những người cùng khổ', author: 'Victor Hugo', book_type: :paper)
    expect(book).to be_valid
  end

  it 'should be invalid' do
    book = Book.new()
    expect(book).not_to be_valid
  end

  it 'should be invalid without book_type' do
    book = Book.new(title: Faker::Lorem.characters,
                    author: Faker::Lorem.characters)
    expect(book).not_to be_valid
  end

  it 'should be invalid without author' do
    book = Book.new(title: Faker::Lorem.characters, book_type: :paper)
    expect(book).not_to be_valid
  end

  it 'should be invalid without title' do
    book = Book.new(author: Faker::Lorem.characters, book_type: :paper)
    expect(book).not_to be_valid
  end

  it 'title should be unique' do
    FactoryGirl.create(:book)
    expect(build(:book, title: 'Những người cùng khổ', author: 'V.Hugo', book_type: :paper)).not_to be_valid
  end

  it 'title should not shorter than 4 chars' do
    expect(build(:book, title: "a" * 3)).not_to be_valid
  end

  it 'title should not longer than 255 chars' do
    expect(build(:book, title: "a" * 256)).not_to be_valid
  end

end