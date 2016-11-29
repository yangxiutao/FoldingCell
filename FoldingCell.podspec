
Pod::Spec.new do |s|

  s.name         = "FoldingCell"
  s.version      = "1.0.0"
  s.summary      = "A short description of FoldingCell."

  
  s.description  = <<-DESC
		   It is a Folding Cell used on iOS, which implement by Objective-C.
                   DESC

  s.homepage     = "https://github.com/yangxiutao/FoldingCell.git"
  

  s.license      = "MIT"
   

  s.author             = { "yangxiutao" => "546822414@qq.com"}
  

  s.platform     = :ios, "8.0"
  s.requires_arc = true
  s.source       = { :git => "https://github.com/yangxiutao/FoldingCell.git", :tag => "{s.version}" }


 

  s.source_files  = "FoldingCell/", "FoldingCell/FoldingCell/FoldingCell/FoldingTableView/*.{h,m}"
   
  

  s.frameworks = 'Foundation', 'UIKit'

end
