import UIKit

class TravelHistoryTableController: UIViewController{
    
    @IBOutlet weak var travelHistory: UITableView!
    var tripsModel = tripModel(tripStorage: TravelUserDefualtsDB(storageKey: "trips"))

    override func viewDidLoad() {
        super.viewDidLoad()
        travelHistory.dataSource = self
        travelHistory.delegate = self
        travelHistory.register(CustomTableViewCell.self, forCellReuseIdentifier: "travelHistoryCell")

    }
}

extension TravelHistoryTableController :  UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripsModel.getTripsName().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelHistoryCell", for: indexPath) as! CustomTableViewCell
        let tripName = tripsModel.getTripsName()[indexPath.row]
        cell.textLabel?.text = tripName
        
        return cell
    }
    
}
