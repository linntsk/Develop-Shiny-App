library(shiny)
library(ggplot2)

data <- read.csv("./HPdata.csv", header=T, sep=",")
colnames(data)[10] <- "Price"
colnames(data)[11] <- "Area"
colnames(data)[14] <- "Unit.Price"
colnames(data)[15] <- "Effective.Date"

meanpd = aggregate(data$Unit.Price, list(data$Postal.District), mean)
colnames(meanpd) = c("postaldistrict","meanpsf")
meanpd[27,1] = 6
meanpd[28,1] = 24
meanpd <- meanpd[with(meanpd, order(postaldistrict)),]
meanpd$postalname <-c("Raffles Place, Cecil, Marina, People's Park",
                      "Anson, Tanjong Pagar",
                      "Queenstown, Tiong Bahru",
                      "Telok Blangah, Harbourfront",
                      "Pasir Panjang, Hong Leong Garden, Clementi New Town",
                      "High Street, Beach Road (part)",
                      "Middle Road, Golden Mile",
                      "Little India",
                      "Orchard, Cairnhill, River Valley",
                      "Ardmore, Bukit Timah, Holland Road, Tanglin",
                      "Watten Estate, Novena, Thomson",
                      "Balestier, Toa Payoh, Serangoon",
                      "Macpherson, Braddell",
                      "Geylang, Eunos",
                      "Katong, Joo Chiat, Amber Road",
                      "Bedok, Upper East Coast, Eastwood, Kew Drive",
                      "Loyang, Changi",
                      "Tampines, Pasir Ris",
                      "Serangoon Garden, Hougang, Ponggol",
                      "Bishan, Ang Mo Kio",
                      "Upper Bukit Timah, Clementi Park, Ulu Pandan",
                      "Jurong",
                      "Hillview, Dairy Farm, Bukit Panjang, Choa Chu Kang",
                      "Lim Chu Kang, Tengah",
                      "Kranji, Woodgrove",
                      "Upper Thomson, Springleaf",
                      "Yishun, Sembawang",
                      "Seletar")

shinyServer(
        function(input, output) {
        # User inputs
        output$op1 <- renderPrint({input$pd})
        output$op3 <- renderPrint({input$area})
        
        # Return the postal district
        datasetInput <- reactive({
                switch(input$pd,
                       "01" = 1,"02" = 2,"03" = 3,"04" = 4,"05" = 5,
                       "06" = 6,"07" = 7,"08" = 8,"09" = 9,"10" =10,
                       "11" = 11,"12" = 12,"13" = 13,"14" = 14,"15" =15,
                       "16" = 16,"17" = 17,"18" = 18,"19" = 19,"20" =20,
                       "21" = 21,"22" = 22,"23" = 23,"24" = 24,"25" =25,
                       "26" = 26,"27" = 27,"28" = 28)
        })
        
        # Generate the district name
        output$op5 <- renderPrint({
                postaldistrict <- datasetInput()
                meanpd[postaldistrict,"postalname"]
        })
                
        # Generate the mean of the unit price for specific district
        output$op2 <- renderPrint({
                postaldistrict <- datasetInput()
                format(meanpd[postaldistrict,"meanpsf"], 
                       digits=2, nsmall=2, big.mark=",")
        })
        
        # Generate the total price 
        output$op4 <- renderPrint({
                postaldistrict <- datasetInput()
                format(meanpd[postaldistrict,"meanpsf"]*input$area, 
                       big.mark=",")
        })

        # Show chart
        output$op6 <- renderPlot({  
        ggplot(data, aes(factor(Postal.District), Unit.Price), out.width=4, out.height=4) + 
                geom_boxplot() + labs(x="Postal District", 
                                      y="Mean psf")
        })
        
        }
)