Pod::Spec.new do |s|
  s.name         = 'XAspect-Foundation_UnicodifyingDescriptionsOfObjects'
  s.version      = '1.2.0'
  s.license      = 'MIT'
  s.summary      = 'Unicodify descriptions of objects in Foundation framework'
  s.homepage     = 'https://github.com/xareelee/ObjCJSONLikeDescription'
  s.authors      = { 'Kang-Yu Xaree Lee' => 'xareelee@gmail.com' }
  s.source       = { :git => "https://github.com/xareelee/ObjCJSONLikeDescription.git", :tag => s.version.to_s, :submodules =>  true }
  
  s.requires_arc = true  

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.default_subspecs = 'Core', 'Foundation'

  s.subspec 'All' do |ss|
    ss.dependency 'XAspect-Foundation_UnicodifyingDescriptionsOfObjects/Core'
    ss.dependency 'XAspect-Foundation_UnicodifyingDescriptionsOfObjects/Foundation'
    ss.dependency 'XAspect-Foundation_UnicodifyingDescriptionsOfObjects/M13OrderedDictionary'
  end

  s.subspec 'Core' do |ss|
    ss.source_files = 'AspectFiles/*.{h,m}'
  end

  s.subspec 'Foundation' do |ss|
    ss.source_files = 'AspectFiles/Foundation/*.{h,m}'
    ss.dependency 'XAspect-Foundation_UnicodifyingDescriptionsOfObjects/Core'
    ss.dependency 'XAspect'
  end

  s.subspec 'M13OrderedDictionary' do |ss|
    ss.source_files = 'AspectFiles/M13OrderedDictionary/*.{h,m}'
    ss.dependency 'XAspect-Foundation_UnicodifyingDescriptionsOfObjects/Core'
    ss.dependency 'XAspect'
    ss.dependency 'M13OrderedDictionary'
  end

end
