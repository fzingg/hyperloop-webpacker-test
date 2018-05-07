class Dashboard < Hyperloop::Router::Component

	render(DIV) do 
		Link("/", class: 'link') { "Home" }
		DIV() {"HOME 2"}.on(:click) {history.push('/')}
		"Number of Todos: #{Todo.count}" 
	end 

end