Pod::Spec.new do |s|
    s.name = 'MixDevice'
    s.version = '1.0.2'
    s.summary = 'Mix Device'
    s.authors = { 'Eric Long' => 'longminxiang@163.com' }
    s.license = 'MIT'
    s.homepage = "https://github.com/longminxiang/MixDevice"
    s.source  = { :git => "https://github.com/longminxiang/MixDevice.git", :tag => "v" + s.version.to_s }
    s.swift_version = '4.2'
    s.ios.deployment_target = '8.0'

    s.source_files = 'Classes/**/*.swift'
end
