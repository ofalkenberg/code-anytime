# Code Anytime

A small set of scripts and advices to let you code whenever you want, while it looks like you are only committing in your free hours.

## Description

Writing and contributing to free software is how developers stay excited for programming and learn new competences. But often it is not allowed to do it during the normal working hours. One must then do it on the weekends or remain awake until late in the night—yet still be a good and productive employee in the day job.

This situation is, in my opinion, quite paradox and also not great. Good employers should acknowledge that contributing to open source software is very important, and they should allow employees to do it even during the day.

Here is a small collection of scripts and advices to allow people to write code whenever they want. On GitHub, the time stamps will always look as if the commits were made early in the morning, during lunch break, in the evening, or over the weekend.

## How to install

1) Copy the files from the `hooks` repository into the `<project_home>/.git/hooks` directory.
2) Make sure they are executable by using: `chmod +x <project_home>/.git/hooks/*`
3) Then you source the shell aliases from the `shell-aliases` directory. Tested only with ZSH currently.

After you have loaded the aliases, please always use the `gitrebase` command instead of `git rebase --interactive`.

And use the `gitpush` command instead of `git push`.

You can also do `git push` to a private, shadow copy of your repository, and only push to the real repository when you are officially not supposed to be working. This can be automated with a cron job.

GitHub's Activity View is a big privacy risk. [Vote for a feature to disable it](https://github.com/orgs/community/discussions/123659).