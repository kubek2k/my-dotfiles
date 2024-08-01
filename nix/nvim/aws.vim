command! -nargs=1 SQSSend :w ! xargs -J {} -0 -- aws sqs send-message --message-body {} --queue-url <args>
