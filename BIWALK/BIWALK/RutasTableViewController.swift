//
//  RutasTableViewController.swift
//  BIWALK
//
//  Created by  on 27/2/19.
//  Copyright © 2019 Izaisa. All rights reserved.
//

import UIKit
import Firebase


class RutasTableViewController: UITableViewController {
    
    struct Ruta {
        var nombre: String
    }
    var rutas = [Ruta]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Acceso con el usuario anónimo de Firebase
      //  Auth.auth().signInAnonymously() { (user, error) in
            
            // UID de usuario asignado por Firebase
           // let uid = user!.uid
           // log.debug("Usuario: \(uid)")
            
     
        
                    
                
                    
                db.collection("rutas").getDocuments() { (querySnapshot, err) in
                    
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            // Limpiar el array de objetos
                            self.rutas.removeAll()

                            for document in querySnapshot!.documents {
                                // Recuperar los datos de la lista y crear el objeto
                                let datos = document.data()
                                let nombre = datos["nombre"] as? String ?? "?"
                                let ruta = Ruta(nombre : nombre)
                                self.rutas.append(ruta)
                            }

                            self.tableView.reloadData()
                        }
                }

        
        
            
    }
        
    
        
        


    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rutas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaItemLista", for: indexPath) as! ItemTableViewCell

        cell.etiquetaRutas.text = rutas[indexPath.row].nombre

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
