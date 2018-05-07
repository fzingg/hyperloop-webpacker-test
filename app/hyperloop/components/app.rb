class App < Hyperloop::Router
	history :browser

	route do
    DIV do
      Switch do
        Route('/', exact: true, mounts: Dashboard)
        
      end
    end
  end
end