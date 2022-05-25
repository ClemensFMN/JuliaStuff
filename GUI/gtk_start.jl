using Gtk

numClicked = 0


function on_button_clicked(w)
  global numClicked += 1
  set_gtk_property!(l, :label, "clicked, $numClicked times.")
  # println(numClicked)
  # println("The button has been clicked")
end

win = GtkWindow("My First Gtk.jl Program", 400, 200)
vbox = GtkBox(:v)
push!(win, vbox)

b = GtkButton("Click Me")
push!(vbox,b)
l = GtkLabel("clicked, $numClicked times.")
push!(vbox,l)
signal_connect(on_button_clicked, b, "clicked")

showall(win)
