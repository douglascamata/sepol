def logar(usuario)
	visit new_usuario_session_path
	fill_in 'Email', with: usuario.email
	fill_in 'Password', with: usuario.password
	click_button 'Sign in'
end