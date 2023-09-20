import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if let imageView = self.imageView {
            
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = imageView.frame.size.height / 2
        }
    }
}
