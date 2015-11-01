Pod::Spec.new do |s|
  s.name         = 'ObjCJSONLikeDescription'
  s.version      = '1.3.1'
  s.license      = 'MIT'
  s.summary      = 'JSON-like and unicodify descriptions of Objective-C collection objects'
  s.homepage     = 'https://github.com/xareelee/ObjCJSONLikeDescription'
  s.authors      = { 'Kang-Yu Xaree Lee' => 'xareelee@gmail.com' }
  s.source       = { :git => "https://github.com/xareelee/ObjCJSONLikeDescription.git", :tag => s.version.to_s, :submodules =>  true }
  
  s.requires_arc = true  

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.default_subspecs = 'Core', 'Foundation'

  s.subspec 'All' do |ss|
    ss.dependency 'ObjCJSONLikeDescription/Core'
    ss.dependency 'ObjCJSONLikeDescription/Foundation'
    ss.dependency 'ObjCJSONLikeDescription/M13OrderedDictionary'
  end

  s.subspec 'Core' do |ss|
    ss.source_files = 'ObjCJSONLikeDescription/*.{h,m}'
  end

  s.subspec 'Foundation' do |ss|
    ss.source_files = 'ObjCJSONLikeDescription/Foundation/*.{h,m}'
    ss.dependency 'ObjCJSONLikeDescription/Core'
    ss.dependency 'XAspect'
  end

  s.subspec 'M13OrderedDictionary' do |ss|
    ss.source_files = 'ObjCJSONLikeDescription/M13OrderedDictionary/*.{h,m}'
    ss.dependency 'ObjCJSONLikeDescription/Core'
    ss.dependency 'XAspect'
    ss.dependency 'M13OrderedDictionary'
  end

end
