//
//  ViewController.swift
//  CalculadoraSwift
//
//  Created by Joaquin Custodio  on 9/2/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Operaciones: UILabel!
    @IBOutlet weak var Resultado: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    //Botones
    @IBOutlet weak var ac: botonredondo!
    @IBOutlet weak var borrar: botonredondo!
    @IBOutlet weak var porcentaje: botonredondo!
    @IBOutlet weak var dividir: botonredondo!
    @IBOutlet weak var uno: botonredondo!
    @IBOutlet weak var dos: botonredondo!
    @IBOutlet weak var tres: botonredondo!
    @IBOutlet weak var cuatro: botonredondo!
    @IBOutlet weak var cinco: botonredondo!
    @IBOutlet weak var seis: botonredondo!
    @IBOutlet weak var restar: botonredondo!
    @IBOutlet weak var multiplicar: botonredondo!
    @IBOutlet weak var siete: botonredondo!
    @IBOutlet weak var ocho: botonredondo!
    @IBOutlet weak var nueve: botonredondo!
    @IBOutlet weak var sumar: botonredondo!
    @IBOutlet weak var zero: botonredondo!
    @IBOutlet weak var punto: botonredondo!
    @IBOutlet weak var igualBoton: botonredondo!
    
    let caracterespecial = CharacterSet(charactersIn: "+-,%*/")
    var calculos:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Color del fondo
        backgroundView.backgroundColor = .black
        //Por defecto los valores son nulos
        limpiar()
    }
    
    //MARK: Funciones
    
    //Reinicia los valores
    func limpiar(){
        calculos = ""
        Resultado.text = "0"
        Operaciones.text = ""
        Resultado.font = Resultado.font.withSize(90)
    }
    
    //Historial de los cálculos, validar
    func sumarcalculos(value: String){
        let sufijo = calculos.suffix(1).rangeOfCharacter(from: caracterespecial)
        let comprobar = value.rangeOfCharacter(from: caracterespecial)
        let prefijo = calculos.prefix(1).rangeOfCharacter(from: caracterespecial)
        
        if ( sufijo != nil && comprobar != nil)  {
             return
        }
        
        if(prefijo != nil){
            return
        }
        
        if (Operaciones.text?.count == 9){
            return
        }
        
        calculos = calculos + value
        //El historial de las operaciones esta limitado a 9
        Operaciones.text = calculos.maxLength(length: 9)
    }
    
    //Borrar último carácter
    func borrarUltimo(){
        if(!calculos.isEmpty){
            calculos.removeLast()
            Operaciones.text = calculos
        }
    }
    
    //Cálcular, pasar de un double a un String y mostrarlo en la lbl
    func igual() {
        
        if ( calculos.suffix(1).rangeOfCharacter(from: caracterespecial) != nil)  {
             return
        }
        
        let comprobarPorcentaje = calculos.replacingOccurrences(of: "&", with: "0.01")
        let expresion = NSExpression(format: comprobarPorcentaje)
        
        
        let resultado = expresion.expressionValue(with: nil, context: nil) as! Double
        let resultadoString = formatoResultado(result: resultado)
        Resultado.text = resultadoString.maxLength(length: 9)
        
        //Cambiar el tamaño de la letra dependiendo su longitud
        if(resultadoString.count >= 7){
            Resultado.font = Resultado.font.withSize(55)
        }else{
            Resultado.font = Resultado.font.withSize(90)
        }

        Operaciones.text = ""
        calculos = ""
    }
    
    //Miramos si es par o no, si es par mostramos decimales
    func formatoResultado(result:Double) -> String{
        if(result.truncatingRemainder(dividingBy: 1) == 0){
            return String(format: "%.0f", result)
        }else{
            return String(format: "%.2f", result)
        }
    }
        
    //MARK: Acciones de los botones
    
    @IBAction func pulsado(_ sender: UIButton) {
        
        //tags de los botones
        let tagsBotones: Int = sender.tag
        
        switch tagsBotones {
        case 11:
            limpiar()
        case 12:
            borrarUltimo()
        case 13:
            sumarcalculos(value: "%")
        case 14:
            sumarcalculos(value: "/")
        case 15:
            sumarcalculos(value: "*")
        case 16:
            sumarcalculos(value: "-")
        case 17:
            sumarcalculos(value: "+")
        case 18:
            igual()
        case 19:
            sumarcalculos(value: ",")
        default:
            sumarcalculos(value:String(sender.tag))
        }
    }
}

//MARK: Diseño de los botones

class botonredondo: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setUp() {
        self.layer.cornerRadius = frame.height / 3
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setUp()
    }
}

//MARK: Limitador de caracteres en una string

extension String {
   func maxLength(length: Int) -> String {
       var str = self
       let nsString = str as NSString
       if nsString.length >= length {
           str = nsString.substring(with:
               NSRange(
                location: 0,
                length: nsString.length > length ? length : nsString.length)
           )
       }
       return  str
   }
}
