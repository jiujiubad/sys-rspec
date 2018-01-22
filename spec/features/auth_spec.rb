require 'rails_helper'

feature "register and login", :type => :feature do
  # 测试注册流程
  scenario "register" do
    visit "/users/sign_up"  # 浏览注册页面
    expect(page).to have_content("Sign up")
    within("#new_user") do  # 填表单
      fill_in "Email", with: "admin@example.com"
      fill_in "Password", with: "111111"
      fill_in "Password confirmation", with: "111111"
    end
    click_button "Sign up"
    # 检查文字。这文字是 Devise 默认会放在 flash[:notice] 上的
    expect(page).to have_content("Welcome! You have signed up successfully")
    # 检查数据库里面最后一笔真的有刚刚填的资料
    user = User.last
    expect(user.email).to eq("admin@example.com")
  end

  # 测试登录登出流程
  scenario "login and logout" do
    user = User.create!( :email => "admin@example.com", :password => "111111")
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "Email", with: "admin@example.com"
      fill_in "Password", with: "111111"
    end
    click_button "Log in"  # 点击登入按钮
    expect(page).to have_content("Signed in successfully")
    click_link "登出"  # 点击主选单的登出超连结
    expect(page).to have_content("Signed out successfully")
  end

end
