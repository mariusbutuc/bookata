gems=(
  reek
  rspec
  rubocop
  solargraph
)

for gem in "${gems[@]}"
do
  if gem list -i "^$gem$" >/dev/null
  then
    echo "✅ $gem is already available"
  else
    gem install $gem
  fi
done
