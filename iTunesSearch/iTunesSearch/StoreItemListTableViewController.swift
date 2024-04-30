
import UIKit

@MainActor
class StoreItemListTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var filterSegmentedControl: UISegmentedControl!
    
    let storeItemVC = StoreItemController()
    var items = [StoreItem]()
    var imageLoadTasks: [IndexPath: Task<Void, Never>] = [:]
    
    
    let queryOptions = ["movie", "music", "software", "ebook"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func fetchMatchingItems() {
        
        self.items = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        let mediaType = queryOptions[filterSegmentedControl.selectedSegmentIndex]
        
        if !searchTerm.isEmpty {
            
            let query = [
                "term": searchTerm,
                "media": mediaType,
                "attribute": "movieTerm",
                "lang": "en_us",
                "limit": "10"
            ]
            
            Task {
                do {
                    let storeItems = try await storeItemVC.fetchItems(matching: query)
                    storeItems.forEach { item in
                        print("""
                        Title: \(item.title)
                        Composer: \(item.composer)
                        Kind: \(item.kind)
                        Description: \(item.description)
                        
                        """)
                    }
                    items = storeItems
                    self.tableView.reloadData()
                } catch {
                    print(error)
                }
            }
            // use the item controller to fetch items
            // if successful, use the main queue to set self.items and reload the table view
            // otherwise, print an error to the console
        }
    }
    
    func configure(cell: ItemCell, forItemAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        cell.name = item.title
        cell.artist = item.composer
        cell.artworkImage = nil
        
        storeItemVC.fetchArtworkImage(for: item) { image in
            if let image = image {
                DispatchQueue.main.async {
                    cell.artworkImage = image
                }
            } else {
                print("Failed to fetch artwork image for item \(item.title)")
            }
        }
    
        
        
        // set cell.name to the item's name
        
        // set cell.artist to the item's artist
        
        // set cell.artworkImage to nil
        
        // initialize a network task to fetch the item's artwork keeping track of the task
        // in imageLoadTasks so they can be cancelled if the cell will not be shown after
        // the task completes.
        //
        // if successful, set the cell.artworkImage using the returned image
    }
    

    
    @IBAction func filterOptionUpdated(_ sender: UISegmentedControl) {
        
        fetchMatchingItems()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath) as! ItemCell
        configure(cell: cell, forItemAt: indexPath)

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // cancel the image fetching task if we no longer need it
        imageLoadTasks[indexPath]?.cancel()
    }
}

extension StoreItemListTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
}

