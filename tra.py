#TRABAJO DE HERENCIA DE PROGRAMACÍON ORIENTADA A OBJETOS 2DO CORTE

#ESTUDIANTES: JUAN DAVID MAJIN ALVAREZ - JHOAN SEBASTIAN VELASCO MEJIA

"""Vamos hacer el trabajo de herencia de 2do corte de POO tomando 
   como ejemplo la universidad y con sus 5 calses hijas """


from ast import main


class Universidad():

        #creamos el constructor de la clase padre con sus atributos
        def __init__(self, nombre, ciudad, telefono):
                
                self.nombre = nombre
                self.ciudad = ciudad
                self.tel = telefono
                

              
                    
#ahora creamos la clase facultad que hereda de la clase Universidad                  
class Facultad(Universidad):
       
       def __init__(self, nombre, ciudad, telefono, decano):
              super().__init__(nombre, ciudad, telefono)

              #le añadimos a esta clase facultad un atributo llamado decanos   
              self.decano = decano

             
                     
                     

#2da clase hija
class PersonaEstudiante(Universidad):
       
       def __init__(self, nombre, apellido,ciudad, telefono, añoingreso):
              super().__init__(nombre, ciudad, telefono)

              #aqui le agregamos 3 atributos que pueden tener el estudiante
              self.ape = apellido
              self.añoing = añoingreso
              
              

              
                     
                     
#3ra clase hija
class PersonaAdministrativo(Universidad):
       
       def __init__(self, nombre, ciudad, telefono, cargo):
              super().__init__(nombre, ciudad, telefono)

              self.cargo = cargo

       
                     

#4ta clase hija
class PersonaAseo(Universidad):
       
       def __init__(self, nombre, ciudad, telefono, area):
              super().__init__(nombre, ciudad, telefono)

              self.area = area 

                     
           

#5ta clase hija
class PersonaVigilancia(Universidad):
       
       def __init__(self, nombre, apellido, ciudad, telefono, rango):
              super().__init__(nombre, ciudad, telefono)

              self.ape = apellido
              self.ran = rango
             

                     
#vamos hacer y organizar el main para poder ejecutar el codigo
if __name__ == '__main__':

       #aqui creamos ejemplos para ejecutar
       universidad1 = Universidad("Unicomfacauca","Popayán", 3124589758)
       facultad = Facultad("Ciencias empresariales", "Popayán",3251489743,"Denis Agusto Lara P.")
       estudiante = PersonaEstudiante("Sebastian","Velasco","Popayán",3174575489,2022,)
       admv = PersonaAdministrativo("Victoria eugenia patiño","Popayán",8386000,"Rectora")
       aseo = PersonaAseo("Andres camayo","Santader de quilichao",3125874562,"cafeteria")
       vigilante = PersonaVigilancia("David","Majin","Popayán",3135896241,"Cabo3ro")
       

       print ("UNIVERSIDAD ","\n Nombre: ", universidad1.nombre, "\n Ciudad: ", universidad1.ciudad, "\n Telefono: ", universidad1.tel)      
       print ("FACULTAD","\n Nombre: ", facultad.nombre, "\n Ciudad: ", facultad.ciudad, "\n Telefono: ", facultad.tel, "\n Decano: ", facultad.decano)
       print ("ESTUDIANTE","\n Nombre:", estudiante.nombre, "\n Apellido: ", estudiante.ape, "\n Ciudad: ", estudiante.ciudad, "\n Telefono: ", estudiante.tel, "\n Año de ingreso: ", estudiante.añoing)
       print ("ADMINISTRATIVOS","\n Nombre: ", admv.nombre, "\n Ciudad: ", admv.ciudad, "\n Telefono: ", admv.tel, "\n Cargo: ", admv.cargo)
       print ("ASEO","\n Nombre: ", aseo.nombre,"\n Ciudad: ", aseo.ciudad,"\n Telefono: ", aseo.tel,"\n Area de aseo: ", aseo.area)
       print ("VIGILANTE","\n Nombre: ", vigilante.nombre, "\n Apellido: ", vigilante.ape, "\n Ciudad: ", vigilante.ciudad, "\n Telefono: ", vigilante.tel, "Rango: ", vigilante.ran)