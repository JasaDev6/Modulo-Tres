import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtEdad: UITextField!
    @IBOutlet weak var switchStatus: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func conexion() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }


    @IBAction func savePerson(_ sender: UIButton) {
        let context = self.conexion()
        let entidadPersonas = NSEntityDescription.entity(forEntityName: "Persona", in: context)
        let newPersona = NSManagedObject(entity: entidadPersonas!, insertInto: context)
        
        newPersona.setValue(self.txtNombre.text, forKey: "nombre")
        newPersona.setValue(Int16(self.txtEdad.text!), forKey: "edad")
        newPersona.setValue(self.switchStatus.isOn, forKey: "estado")
        
        do {
            try context.save()
            print("Se guardaron los datos")
            self.txtNombre.text = ""
            self.txtEdad.text = ""
            self.switchStatus.isOn = false
        } catch let err as NSError {
            print("Error al guardar los datos", err)
        }
    }
    
    @IBAction func listPersons(_ sender: UIButton) {
        let context = self.conexion()
        let fetchRequest: NSFetchRequest<Persona> = Persona.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            print("Numero de registros = \(result.count)")
            for res in result as [NSManagedObject] {
                let nombrePersona = res.value(forKey: "nombre")
                let edadPersona = res.value(forKey: "edad")
                let estadoPersona = res.value(forKey: "estado")
                
                print("Nombre: \(nombrePersona!) - edad: \(edadPersona!) - estado: \(estadoPersona!)")
                
            }  
        } catch let err as NSError {
            print("Error al obtener los datos", err)
        }
    }
    
    @IBAction func deleteAll(_ sender: UIButton) {
        let context = self.conexion()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Persona")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let err as NSError {
            print("Error al borrar los datos", err)
        }
    }
    
}

