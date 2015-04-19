---
layout: post
title: "Rails Tip: TODO, FIXME and OPTIMIZE code comments"
categories: articles
---

Ruby on Rails has so much that it's often easy to overlook some of the simple things it can do for you. For example you can leave special comment or notes in your code for Rails to remind you of tasks that you need to do like this:

```ruby
class User < ActiveRecord::Base
  # TODO Refactor this class, it's way too big!
  # FIXME broke some_method during refactor
  # OPTIMIZE moar speed!!!
  ...
end
```

You get the idea. I called them special comments in the previous paragraph but
really they are just your usual comments but the `TODO`, `FIXME` and
`OPTIMIZE` keywords make them special when you run the following rake task:

```
$ rake notes
app/models/user.rb:
  * [2] [TODO] Refactor this class, it's way too big!
  * [3] [FIXME] broke some_method during refactor
  * [4] [OPTIMIZE] moar speed!!!
```

For the power users out there you can add support for new file extensions using
`config.annotations.register_extensions` option, which receives a list of the
extensions with its corresponding regex to match it up.

```ruby
# Match .scss, .sass or .less comments. Example // TODO make some notes
config.annotations.register_extensions("scss", "sass", "less") do |annotation|
  /\/\/\s*(#{annotation}):?\s*(.*)$/
end
```

You should checkout the [short section in the Rails Guides](rails-cli-notes) to
find out more about this handy Rake task, including how to list your own
annotations.

[rails-cli-notes]: http://guides.rubyonrails.org/command_line.html#notes
