//
//  CharactersListSceneViewController.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

import UIKit

protocol CharactersListSceneViewControllerinput {
    func displayList(viewModel: CharactersListSceneModel.List.ViewModel)
    func displayDetail(viewModel: CharactersListSceneModel.Detail.ViewModel)
}

protocol CharactersListSceneViewControllerOutput {
    func fetchCharactersList(request: CharactersListSceneModel.List.Request)
    func prepareCharacterDetail(request: CharactersListSceneModel.Detail.Request)
}

public final class CharactersListSceneViewController: UIViewController {
    
    private var charactersList: [CharactersListSceneModel.DisplayedCharacter] = []
    private var currentPage: Int = 0
    private var totalPages: Int = 1
    private var isFetching: Bool = false
    
    struct Cells {
        static let RMcellID = "RMCell"
    }
    
    // MARK: Object lifecycle
    
    var output: CharactersListSceneViewControllerOutput!
    var router: (NSObjectProtocol & CharactersListSceneRouterInput & CharactersListDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup()
    {
        CharactersListSceneConfigurator.sharedInstance.configure(viewController: self)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        settingTableView()
        fetchNextPage()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: Setting View
    
    private func settingView() {
        title = "RaM Characters"
        view.backgroundColor = .systemBackground
    }
    
    // MARK: Setting UITableView
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(RMTableViewCell.self,
                           forCellReuseIdentifier: Cells.RMcellID)
        
        return tableView
    }()
    
    private func settingTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(refreshData),
                                            for: .valueChanged)
    }
    
    private func createSpinerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.size.width,
                                              height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    @objc private func refreshData() {
        currentPage = 0
        charactersList = []
        fetchNextPage()
    }
    
    // MARK: Privates
    
    private func fetchNextPage() {
        if isFetching || currentPage == totalPages { return }
        
        currentPage += 1
        isFetching = true
        tableView.tableFooterView = createSpinerFooter()
        let request = CharactersListSceneModel.List.Request(page: currentPage)
        output.fetchCharactersList(request: request)
    }
    
    private func prepareDetailCharacter(withId id: Int) {
        let request = CharactersListSceneModel.Detail.Request(characterId: id)
        output.prepareCharacterDetail(request: request)
    }
}

// MARK: - CharactersListSceneViewControllerinput
extension CharactersListSceneViewController: CharactersListSceneViewControllerinput {
    func displayList(viewModel: CharactersListSceneModel.List.ViewModel) {
        charactersList.append(contentsOf: viewModel.list)
        totalPages = viewModel.pages
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
        isFetching = false
        tableView.tableFooterView = nil
    }
    
    func displayDetail(viewModel: CharactersListSceneModel.Detail.ViewModel) {
        router?.routeToCharacterDetail()
    }
}

// MARK: - UITableViewDelegate
extension CharactersListSceneViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let character = charactersList[indexPath.row]
        prepareDetailCharacter(withId: character.id)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            fetchNextPage()
        }
    }
}

// MARK: - UITableViewDataSource
extension CharactersListSceneViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.RMcellID, for: indexPath) as! RMTableViewCell
        
        let character = charactersList[indexPath.row]
        cell.configure(withImageUrlString: character.image, andTitle: character.name)
        return cell
    }
}
