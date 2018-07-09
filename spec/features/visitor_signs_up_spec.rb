require 'rails_helper'

feature 'Visitor signs up' do
  scenario 'by navigating to the page' do
    visit sign_in_path

    click_link I18n.t('sessions.form.sign_up')

    expect(current_path).to eq sign_up_path
  end

  scenario 'only step_one' do
    sign_up_step_one_with(first_name: 'Jeanne', last_name: 'Calmos',
      street_number: '1', street_name: 'place de la République', zip_code: '75010', city: 'Paris',
      email: 'achat@robiweb.net', password: 'password')

    expect_user_to_complete_step_one
  end

  scenario 'tries with invalid email' do
  end

  scenario 'tries with blank password' do
  end
  def sign_up_step_one_with(params)
    visit sign_up_path
    fill_in 'user_first_name', with: params[:first_name]
    fill_in 'user_last_name', with: params[:last_name]
    fill_in 'user_street_number', with: params[:street_number]
    fill_in 'user_street_name', with: params[:street_name]
    fill_in 'user_zip_code', with: params[:zip_code]
    fill_in 'user_email', with: params[:email]
    fill_in 'user_password', with: params[:password]
    click_button I18n.t('helpers.buttons.next_step')
  end

  def sign_up_with(params)
    sign_up_step_one_with(params)
    choose params[:situation]
    fill_in 'user_pdl', with: params[:pdl]
    click_button I18n.t('helpers.buttons.submit')
  end

  def expect_user_to_complete_step_one
    expect(page).to have_text('Situation')
  end
end

