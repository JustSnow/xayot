u = User.create(
	:email => 'admin@example.com', 
	:password => '123', 
	:password_confirmation => '123', 
	:role => 'admin'
)

categories = {
	'main' => "Главная",
	'news' => "Новости",
	'about' => "О Хаётхон",
	'main-sidebar' => 'Главная Сайдбар'
}

main_categories = {
	'articles' => "Статьи Хаётхон",
	'people' => "Люди о Хаётхон",
	'message' => "Послания",
}

categories.each do |index, value|
	c = Category.nested_set.new
	c.save!
	c = c.build_content
	c.name = "#{value}"
	c.alias = "#{index}"
	c.user_id = u.id
	c.save!
end

main_categories.each do |index, value|
	c = Category.nested_set.new
	c.parent_id = 4
	c.save!
	c = c.build_content
	c.name = "#{value}"
	c.alias = "#{index}"
	c.user_id = u.id
	c.save!
end

# posts
20.times do |n|
	post = Post.create(
		category_id: rand(1..6),
		intro: "You need to use the ps command. 
						It provide information about the currently running processes, 
						including their process identification numbers (PIDs). 
						Both Linux and UNIX support the ps command to display information about all running process. 
						The ps command gives a snapshot of the current processes. 
						If you want a repetitive update of this status, use top, atop, and/or htop command as described below.",
    full: "You need to use the ps command. 
    			 It provide information about the currently running processes, 
    			 including their process identification numbers (PIDs). 
    			 Both Linux and UNIX support the ps command to display information about all running process. 
    			 The ps command gives a snapshot of the current processes. 
    			 If you want a repetitive update of this status, use top, atop, 
    			 and/or htop command as described below.You need to use the ps command. 
    			 It provide information about the currently running processes, 
    			 including their process identification numbers (PIDs). 
    			 Both Linux and UNIX support the ps command to display information about all running process. 
    			 The ps command gives a snapshot of the current processes. 
    			 If you want a repetitive update of this status, use top, atop, and/or htop command as described below."
	)
	
	post = post.build_content
	post.user_id = u.id
	post.name = "Post - #{n}"
	post.save
end
