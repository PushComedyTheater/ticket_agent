docker run -d -p 22:22 -P --name elixir-build -v "$(pwd)"/releases:/build elixir-build
mix edeliver build release
