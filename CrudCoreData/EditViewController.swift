import UIKit
import CoreData

class EditViewController: UIViewController {
    
    var personaEditar: Persona!
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var edad: UITextField!
    @IBOutlet weak var estado: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombre.text = personaEditar.nombre
        edad.text = "\(personaEditar.edad)"
        estado.isOn = personaEditar.estado
    }
    
    func conexion() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func editar(_ sender: UIButton) {
        let context = self.conexion()
        
        personaEditar.setValue(self.nombre.text, forKey: "nombre")
        personaEditar.setValue(Int16(self.edad.text!), forKey: "edad")
        personaEditar.setValue(self.estado.isOn, forKey: "estado")
        
        do {
            try context.save()
            performSegue(withIdentifier: "enviarTabla", sender: self)
        } catch let err as NSError {
            print("Error al guardar los datos", err)
        }
    }
    

}
