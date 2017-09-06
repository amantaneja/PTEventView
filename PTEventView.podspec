Pod::Spec.new do |s|
s.name             = 'PTEventView'
s.version          = '0.3.0'
s.summary          = 'An Event View based on Apple’s Event Detail View. Written in Swift 3. Supports ARC, Autolayout and editing via StoryBoard.'

s.description      = <<-DESC
An Event View based on Apple’s Event Detail View. Written in Swift 3. Supports ARC, Autolayout and editing via StoryBoard.It also allows changing the color of Event View and the EventView Text. 
DESC

s.homepage         = 'https://github.com/amantaneja/PTEventView'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Aman Taneja' => 'taneja.aman161@gmail.com' }
s.source           = { :git => 'https://github.com/amantaneja/PTEventView.git', :tag => s.version.to_s }

s.ios.deployment_target = '10.0'
s.source_files = 'Demo/PTEventViewDemo/PTEventView/*'

end
