#!/usr/bin/env rew
_direnv = presolve process.cwd(), '.envrc'
_flakenix = presolve process.cwd(), 'flake.nix'

flake_content = read './flake.nix'
env_content = read './.envrc'

write _direnv, env_content
write _flakenix, flake_content

exec 'cd ' + process.cwd() + ' && git add flake.nix'