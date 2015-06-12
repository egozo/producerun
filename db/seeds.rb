#encoding: utf-8

puts 'Seeding the database...'

# if you change categories, please update on app/views/projects/new.html.slim page also
[
  { pt: 'Opt1',ru: '�������� ��������' },
  { pt: 'Opt2',ru: '����� ��������' },
  { pt: 'Opt3',ru: '���������� ���������' },
  { pt: 'Opt4',ru: '���������' },

].each do |name|
   category = Category.find_or_initialize_by(name_pt: name[:pt])
   category.update_attributes({
     name_en: name[:ru]
   })
   puts name
 end

{
  compacny_name: 'Russin Pets Crowdfunding',
  company_logo: 'http://www.producerun.com/wp-content/uploads/2014/11/rsz_producerun-green.png',
  host: '',
  base_url: "",
  email_contact: 'tp@inbox.ru',
  email_payments: 'tp@inbox.ru',
  email_projects: 'tp@inbox.ru',
  email_system: 'tp@inbox.ru',
  email_no_reply: 'tp@inbox.ru',
  facebook_url: "https://www.facebook.com/producerun",
  facebook_app_id: '173747042661491',
  twitter_url: 'http://twitter.com/producerun',
  twitter_username: "producerun",
  mailchimp_url: "http://producerun.us8.list-manage.com/subscribe/post?u=d7cada44d74cc8dec9c798429&amp;id=4538752d65",
  catarse_fee: '0.10',
  support_forum: 'http://support.producerun.com/',
  base_domain: 'producerun.com',
  uservoice_secret_gadget: 'change_this',
  uservoice_key: 'uservoice_key',
  faq_url: 'http://support.producerun.com/',
  feedback_url: 'http://support.producerun.com/',
  terms_url: 'http://support.producerun.com/',
  privacy_url: 'http://support.producerun.com/',
  about_channel_url: 'http://blog.producerun.com',
  instagram_url: 'http://instagram.com/producerun_',
  blog_url: "http://blog.producerun.com",
  farmers_blog_url: "http://farmers.producerun.com",
  github_url: 'http://github.com/producerun',
  contato_url: 'http://support.producerun.com/',
  mixpanel_token: 'e0e80f9f416708ba621aaf3d6aff3b85',
  sendgrid_user_name: 'hackandgrow',
  minimum_goal_for_video: '5000',
  aws_bucket: 'russianbeast',

}.each do |name, value|
   conf = CatarseSettings.find_or_initialize_by(name: name)
   conf.update_attributes({
     value: value
   }) if conf.new_record?
end

OauthProvider.find_or_create_by!(name: 'facebook') do |o|
  o.key = '976574999054330'
  o.secret = '729f5c225031bf17512aaff8ad3051cb'
  o.path = 'facebook'
end

puts
puts '============================================='
puts ' Showing all Authentication Providers'
puts '---------------------------------------------'

OauthProvider.all.each do |conf|
  a = conf.attributes
  puts "  name #{a['name']}"
  puts "     key: #{a['key']}"
  puts "     secret: #{a['secret']}"
  puts "     path: #{a['path']}"
  puts
end


puts
puts '============================================='
puts ' Showing all entries in Configuration Table...'
puts '---------------------------------------------'

CatarseSettings.all.each do |conf|
  a = conf.attributes
  puts "  #{a['name']}: #{a['value']}"
end

Rails.cache.clear

user = User.where( name: 'Admin', email: 'super@puper.com').first_or_initialize do |user|
  user.password = 'super@puper.com'
  user.admin = true
  puts "User #{user.email} created"
  user.save
end

user.projects.where(name: "Example project name", category: Category.first, goal: 100, about: "This is about text", video_url: 'https://www.youtube.com/watch?v=IexoJu3TMWM', online_days: 30, headline: 'Example headline').first_or_create do |p|
  puts  "example project created"
  #p.send_to_analysis!
  #p.approve!
end


puts '---------------------------------------------'
puts 'Done!'
