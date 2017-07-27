Pod::Spec.new do |s|
s.name                  = 'AOPLogger'
s.version               = '1.2'
s.summary               = 'A new Logger  '
s.homepage              = 'https://github.com/heroims/AOPLogger'
s.license               = { :type => 'MIT', :file => 'README.md' }
s.author                = { 'heroims' => 'heroims@163.com' }
s.source                = { :git => 'https://github.com/heroims/AOPLogger.git', :tag => "#{s.version}" }
s.platform              = :ios, '5.0'

s.default_subspec = 'Core'

s.subspec 'Core' do |core|
core.source_files          = 'AOPLogger/*.{h,m}'
core.ios.dependency  	'Aspects'
end

s.subspec 'AOPClick' do |aopclick|
aopclick.source_files          = 'AOPClick/*.{h,m}'
aopclick.dependency                'AOPLogger/Core'
end

s.requires_arc          = true
end
