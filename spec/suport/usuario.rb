def logar(usuario)
	visit new_usuario_session_path
  save_and_open_page
	fill_in 'Email', with: usuario.email
	fill_in 'Password', with: usuario.password
	click_button 'Entrar'
end