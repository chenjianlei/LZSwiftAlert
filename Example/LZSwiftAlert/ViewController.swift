//
//  ViewController.swift
//  LZSwiftAlert
//
//  Created by chenjianlei on 08/27/2020.
//  Copyright (c) 2020 chenjianlei. All rights reserved.
//

import UIKit
import LZSwiftAlert

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "alert demo !"
        makeConfig()
    }
    
    private func makeConfig() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
    }
    
    lazy var arrays: [Model] = {
        return [
            Model.init(title: "text", action: .text),
            Model.init(title: "clean", action: .clean),
            Model.init(title: "start", action: .start),
            Model.init(title: "startText", action: .startText),
            Model.init(title: "stop", action: .stop),
            Model.init(title: "stopText", action: .stopText),
            Model.init(title: "block", action: .block),
        ]
    }()
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrays.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch arrays[indexPath.row].action {
        case .text:
            alertText(msg: "test")
        case .clean:
            alertText(msg: "will clean now + 0.25")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.clean()
            }
        case .start:
            alertStartLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.clean()
            }
        case .stop:
            alertStartLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.alertStopLoading()
            }
        case .startText:
            alertStartLoading(msg: "start loading text")
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.clean()
            }
        case .stopText:
            alertStartLoading(msg: "start loading text")
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.alertStopLoading(msg: "stop loading text")
            }
        case .block:
            view.alertText(msg: "this is block") {
                print("success")
            }
//        default:
//            break
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = arrays[indexPath.row].title
        return cell
    }
}

enum AlertAction {
    case text
    case clean
    case start
    case startText
    case stop
    case stopText
    case block
}

struct Model {
    var title: String
    var action: AlertAction
}
