Given /the following (.*?) exist:$/ do |type, table|
  table.hashes.each do |element|
    case type
      when 'users' then User.create element
      when 'articles' then Article.create element
      when 'comments' then Comment.create element
    end
    
  end
end

Given /I am logged in as user "(.*?)" with passcode "(.*?)"$/ do |user, pass|
  visit '/accounts/login'
  fill_in 'user_login', :with => user
  fill_in 'user_password', :with => pass
  click_button 'Login'
  assert page.has_content? 'Login successful'
end

Given /article ids "(\d+)" and "(\d+)" have been merged$/ do |id1, id2|
  Article.find_by_id(id1).merge_with(id2)
end

Then /"(.*?)" should be author of (\d+) articles$/ do |user, count|
  assert Article.where(:user_id => User.find_by_login(user).profile_id).length == Integer(count)
end