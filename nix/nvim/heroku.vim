command! -nargs=* HerokuStart :terminal fd | entr -rcd heroku local:start <args>
command! -nargs=+ HerokuRun :terminal fd | entr -rcd heroku local:run <args>
