//
//  ControladorPantallaDelPost.swift
//  boceto_2_CellView
//
//  Created by Jadzia Gallegos on 10/10/24.
//

import UIKit

class ControladorPantallaDelPost: UIViewController {
    
    let proveedor_publicaciones = ProveedorDePublicaciones.autoreferencia
    
    @IBOutlet var titulo_publicacion: UILabel!
    @IBOutlet var texto_publicacion: UILabel!
    @IBOutlet var nombre_usuario: UILabel!
 
    @IBOutlet var seccion_comentarios: UICollectionView!
    
    public var id_publicacion: Int?
    
    private var publicacion: Post?
    
    private var usuario : Usuario?
    
    private var lista_comentarios: [Comentario] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controlador_de_navegacion = self.navigationController as? mod_navegador_principal
        controlador_de_navegacion?.activar_navigation_bar(actviar: true)
        realizar_descarga_de_informacion()
        
    }
    
    func realizar_descarga_de_informacion(){
        if self.publicacion == nil{
            proveedor_publicaciones.obtener_publicacion(id: self.id_publicacion ?? -1,
                    que_hacer_al_recibir: {
                    [weak self] (publicacion) in self?.publicacion = publicacion
                DispatchQueue.main.async{
                        self?.dibujar_publicacion()
                    }
            })
        }
        else if self.publicacion != nil{
            proveedor_publicaciones.obtener_usuario(id: publicacion!.userId,
                    que_hacer_al_recibir: {
                    [weak self] (usuario) in self?.usuario = usuario
                DispatchQueue.main.async{
                        self?.dibujar_publicacion()
                    }
            })
        }
        
    }
    
    func dibujar_publicacion(){
        guard let publicacion_actual = self.publicacion else{
            return
        }
        titulo_publicacion.text = publicacion_actual.title
        texto_publicacion.text = publicacion_actual.body
        //print(publicacion?.body)
    }
    
}
