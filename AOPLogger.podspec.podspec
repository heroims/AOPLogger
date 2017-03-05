Pod::Spec.new do |s|
s.name                  = 'AOPLogger'
s.version               = '1.0'
s.summary               = 'A new Logger  '
s.homepage              = 'https://github.com/heroims/AOPLogger'
s.license               = { :type => 'MIT', :file => 'README.md' }
s.author                = { 'heroims' => 'heroims@163.com' }
s.source                = { :git => 'https://github.com/heroims/AOPLogger.git', :tag => "#{s.version}" }
s.platform              = :ios, '5.0'
s.source_files          = 'AOPLogger/*.{h,m}'
s.requires_arc          = true
end
