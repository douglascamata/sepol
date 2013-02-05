#encoding: utf-8

require 'spec_helper'

feature 'Login' do
	scenario 'fazer login' do	
		admin = FactoryGirl.create :administrador, email: 'admin@test.br', password: '123456foobar', password_confirmation: '123456foobar'
		visit new_administrador_session_path
		fill_in 'Email', with: admin.email
		fill_in 'Password', with: admin.password
		click_button 'Sign in'		
	end
end