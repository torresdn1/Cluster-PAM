library(tidyverse)
library(cluster)
library(sf)
library(ggrepel)

#Este ejercicio busca resolver una pregunta concreta: 
# Si fuese necesario establecer 25 almacenes de bienes o productos para atender cualquier tipo de emergencias
# en cualquier parte del territorio nacional, ¿dónde deben establecerse dichos almacenes? 
# Lo que se espera es encontrar sitios estratégicos que optimicen las distancias entre ellos y el resto del país. 
# PAM ofrece una respuesta a este tipo de interrogantes. 

#Sobre el método: Kaufman, L., Rousseeuw, P.J.: Finding groups in data: an introduction to clusteranalysis. Wiley Online Library (1990)

#México
mex <- read_sf("mpios.geojson")

#Ubicamos los centroides de cada una de las geometrías 
centroides <- mex %>% 
  st_transform(4326) %>% #CRS
  st_centroid() %>% 
  mutate(long = st_coordinates(.)[,1],
         lat = st_coordinates(.)[,2])

#Matriz con latitud y longitud para PAM
matrix <- cbind(as.data.frame(centroides$lat), as.data.frame(centroides$long))
mat_daisy <- daisy(matrix) 
outcome <- pam(mat_daisy, k=25) 

outcome$medoids # "2442" "1946" "1883" "2356" "197"  "60"   "988"  "289"  "563"  "150"  "1425" "259"  "1893" "274"  "875" "822"  "520"  "1820" "1097" "1048" "1645" "2062" "1185" "1528" "2266"

rm(matrix, outcome, mat_daisy)

mex <- mex %>% 
  mutate(order= 1:n(),
         medoide= ifelse(order %in% c("2442","1946","1883","2356","197",
                                      "60","988", "289", "563", "150", 
                                      "1425", "259", "1893", "274", "875",
                                      "822", "520", "1820", "1097", "1048",
                                      "1645","2062", "1185","1528","2266"), 1, 0))
centroides <- centroides %>% 
  mutate(order= 1:n(),
         medoide= ifelse(order %in% c("2442","1946","1883","2356","197",
                                      "60","988", "289", "563", "150", 
                                      "1425", "259", "1893", "274", "875",
                                      "822", "520", "1820", "1097", "1048",
                                      "1645","2062", "1185","1528","2266"), 1, 0))

mex %>% 
  ggplot()+
  geom_sf(aes(fill= factor(medoide)), size= 0.2)+
  geom_label_repel(data = centroides %>% 
               filter(medoide==1), aes(x = long, y = lat, label = NOM_MUN),
             size=2, alpha= 0.5, nudge_y = 0.5)+
  labs(title= "\n¿Dónde deberían ubicarse 25 almacenes estratégicos para la atención de emergencias?",
       subtitle= "25 municipios medoides para México por ubicación geográfica\nEstimaciones a través del método Partitioning Around Medoids (PAM)\n",
       caption= "Elaborado por Donovan Torres (@torres_dn1)\nNota: El ejercicio sólo contempla la ubicación geográfica y no controla por rutas de comunicación o densidad poblacional\n",
       fill= NULL,
       x="", y="")+
  scale_fill_manual(values = c("#646464", "yellow"))+
  theme(panel.grid = element_blank(),
        panel.background = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        legend.position = "none",
        plot.title = element_text(hjust = 0.5, face = "bold", size=15),
        plot.subtitle = element_text(hjust = 0.5, size=12), 
        plot.caption = element_text(face= "italic", size=10))


