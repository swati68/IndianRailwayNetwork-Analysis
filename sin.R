library(tidyverse)
library(network)
library(CINNA)
library(centiserve)

x<-read_csv("d.csv")    #Reading the data
x

sources<-x %>%
  distinct(`Source Station`) %>%
  rename(label=`Source Station`)

destinations <- x %>%
  distinct(`Destination Station`) %>%
  rename(label=`Destination Station`)

nodes <- full_join(sources, destinations, by = "label")   #Finding distinct nodes for our graph
nodes

nodes<-nodes %>% rowid_to_column("id")   #Giving id to each distinct node
nodes

#Finding the edges for our graph
route<-x %>%
  select(`Source Station`,`Destination Station`,`Distance`)    
route

edges<-route%>%
  left_join(nodes, by = c("Source Station" = "label")) %>% 
  rename(from = id)

edges <- edges %>% 
  left_join(nodes, by = c("Destination Station" = "label")) %>% 
  rename(to = id)

edges <- select(edges, from, to,`Distance`)
edges

#Plotting the graph using network library
routes_network <- network(edges, vertex.attr = nodes, matrix.type = "edgelist", ignore.eval = FALSE)
class(routes_network)
routes_network
plot(routes_network, vertex.cex = 1)

detach(package:network)
rm(routes_network)

#Plotting the graph using igraph library
library(igraph)
routes_igraph <- graph_from_data_frame(d = edges, vertices = nodes, directed = TRUE)
routes_igraph
plot(routes_igraph, edge.arrow.size = 0.5,vertex.cex=10)

#Calculating degree centrality
degree.cent <- centr_degree(routes_igraph, mode = "in","out")
d<-matrix(c(degree.cent$res),ncol=1,byrow=TRUE)
valdeg<-which.max(d[,1])
ar<-matrix(c('Degree Centrality',nodes$label[valdeg]),ncol=2)
colnames(d)<-'Degree Centrality'
rownames(d)<-c(nodes$id)
d<-as.table(d)
d

#Calculating closeness centrality
closeness.cent <- closeness(routes_igraph, mode="all")
cl<-matrix(c(closeness.cent),ncol=1,byrow=TRUE)
valclose<-which.max(cl[,1])
ar<-rbind(ar,c('Closeness Centrality',nodes$label[valclose]))
colnames(cl)<-'Closeness Centrality'
rownames(cl)<-c(nodes$id)
cl<-as.table(cl)
cl

#Calculating betweenness centrality
betweenness.cent<-betweenness(routes_igraph)
b<-matrix(c(betweenness.cent),ncol=1,byrow=TRUE)
valbet<-which.max(b[,1])
ar<-rbind(ar,c('Betweenness Centrality',nodes$label[valbet]))
colnames(b)<-'Betweenness Centrality'
rownames(b)<-c(nodes$id)
b<-as.table(b)
b

#Calculating eigen vector centrality
eigen.cent<-eigen_centrality(routes_igraph)
e<-matrix(c(eigen.cent$vector),ncol=1,byrow=TRUE)
valeig<-which.max(e[,1])
ar<-rbind(ar,c('Eigen vector Centrality',nodes$label[valeig]))
colnames(e)<-'Eigen Vector Centrality'
rownames(e)<-c(nodes$id)
e<-as.table(e)
e

#Calculating subgraph centrality
subgraph.cent<-subgraph_centrality(routes_igraph)
s<-matrix(c(subgraph.cent),ncol=1,byrow=TRUE)
valsub<-which.max(s[,1])
ar<-rbind(ar,c('Subgraph Centrality',nodes$label[valsub]))
colnames(s)<-'Subgraph Centrality'
rownames(s)<-c(nodes$id)
s<-as.table(s)
s

#Calculating page rank centrality
pagerank.cent<-page_rank(routes_igraph)
p<-matrix(c(pagerank.cent$vector),ncol=1,byrow=TRUE)
valpag<-which.max(p[,1])
ar<-rbind(ar,c('Page Rank',nodes$label[valpag]))
colnames(p)<-'Page Rank'
rownames(p)<-c(nodes$id)
p<-as.table(p)
p

#Calculating alpha centrality
alpha.cent<-alpha_centrality(routes_igraph,alpha=0.5)
a<-matrix(c(alpha.cent),ncol=1,byrow=TRUE)
valalp<-which.max(a[,1])
ar<-rbind(ar,c('Alpha Centrality',nodes$label[valalp]))
colnames(a)<-'Alpha centrality'
rownames(a)<-c(nodes$id)
a<-as.table(a)
a

#Calculating Kleinberg's hub centrality score
hu<-hub_score(routes_igraph)$vector
h<-matrix(c(hu),ncol=1,byrow=TRUE)
valhub<-which.max(h[,1])
ar<-rbind(ar,c("Kleinberg's hub Centrality score",nodes$label[valhub]))
colnames(h)<-"Kleinberg's hub Centrality score"
rownames(h)<-c(nodes$id)
h<-as.table(h)
h

#Calculating entropy centrality
ent.cent<-entropy(routes_igraph)
ent<-matrix(c(ent.cent),ncol=1,byrow=TRUE)
valent<-which.max(ent[,1])
ar<-rbind(ar,c("Entropy Centrality",nodes$label[valent]))
colnames(ent)<-"Entropy Centrality"
rownames(ent)<-c(nodes$id)
ent<-as.table(ent)
ent

#Calculating laplacian centrality
lap.cent<-laplacian(routes_igraph)
lap<-matrix(c(lap.cent),ncol=1,byrow=TRUE)
vallap<-which.max(lap[,1])
ar<-rbind(ar,c("Laplacian Centrality",nodes$label[vallap]))
colnames(lap)<-"Laplacian Centrality"
rownames(lap)<-c(nodes$id)
lap<-as.table(lap)
lap

#Calculating semilocal centrality
sem.cent<-semilocal(routes_igraph)
sem<-matrix(c(sem.cent),ncol=1,byrow=TRUE)
valsem<-which.max(sem[,1])
ar<-rbind(ar,c("Semi local Centrality",nodes$label[valsem]))
colnames(sem)<-"Semi local Centrality"
rownames(sem)<-c(nodes$id)
sem<-as.table(sem)
sem

#Calculating harmonic centrality
har.cent<-harmonic_centrality(routes_igraph)
har<-matrix(c(har.cent),ncol=1,byrow=TRUE)
valhar<-which.max(har[,1])
ar<-rbind(ar,c("Harmonic closeness Centrality",nodes$label[valhar]))
colnames(har)<-"Harmonic closeness Centrality"
rownames(har)<-c(nodes$id)
har<-as.table(har)
har

#Calculating local bridging centrality
loc.cent<-local_bridging_centrality(routes_igraph)
loc<-matrix(c(loc.cent),ncol=1,byrow=TRUE)
valloc<-which.max(loc[,1])
ar<-rbind(ar,c("Local Bridging Centrality",nodes$label[valloc]))
colnames(loc)<-"Local Bridging Centrality"
rownames(loc)<-c(nodes$id)
loc<-as.table(loc)
loc

#Calculating leverage centrality
lev.cent<-leverage(routes_igraph)
lev<-matrix(c(lev.cent),ncol=1,byrow=TRUE)
vallev<-which.max(lev[,1])
ar<-rbind(ar,c("Leverage Centrality",nodes$label[vallev]))
colnames(lev)<-"Leverage Centrality"
rownames(lev)<-c(nodes$id)
lev<-as.table(lev)
lev

#Calculating dangalchev closeness centrality
dan.cent<-dangalchev_closeness_centrality(routes_igraph)
dan<-matrix(c(dan.cent),ncol=1,byrow=TRUE)
valdan<-which.max(dan[,1])
ar<-rbind(ar,c("Dangalchev Closeness Centrality",nodes$label[valdan]))
colnames(dan)<-"Dangalchev Closeness Centrality"
rownames(dan)<-c(nodes$id)
dan<-as.table(dan)
dan

#Final array
ar
