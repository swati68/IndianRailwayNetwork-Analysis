# 🚆 Social Network Analysis of Indian Railway Network

This project analyzes the **Indian Railway Network (IRN)** as a **complex weighted graph**, where railway stations are treated as nodes and the distances between them as edge weights.  
Using **R** and graph-theoretic measures, the study investigates connectivity, traffic flow, and centrality metrics to identify the most influential stations within the network.

---

## 📘 Project Overview

Public transport networks are crucial for urban and regional development.  
This project applies **Social Network Analysis (SNA)** techniques to the Indian Railway Network to reveal its **topological structure**, **traffic concentration**, and **potential bottlenecks**.  

The analysis explores how stations are connected, identifies major hubs, and provides insights for optimizing transportation infrastructure.

**Key Objectives:**
- Model the Indian Railway Network as a weighted complex graph.  
- Analyze network characteristics like small-world behavior and connectivity.  
- Use centrality measures to determine the most important stations.  
- Examine congestion patterns and suggest improvements for network planning.

---

## ⚙️ Implementation Details

- **Dataset:** Kaggle Indian Railway Network dataset (1000 entries subset)  
- **Language:** R  
- **Environment:** RStudio  
- **Graph Model:**  
  - Nodes → Railway stations  
  - Edges → Train connections  
  - Weights → Distance between stations  

**Libraries Used:**
- tidyverse
- igraph
- network
- CINNA
- centiserve

---

## 🧠 Methodology
1️⃣ Data Preparation  
Cleaned and filtered columns (train number, station names, distances, etc.).  
Extracted unique nodes and edge weights.  

2️⃣ Network Construction  
Created weighted undirected graphs using igraph and network libraries.  
Visualized the network.  

3️⃣ Centrality Analysis  
Calculated 15 centrality measures to evaluate node importance:  
Degree, Closeness, Betweenness, Eigenvector  
Subgraph, PageRank, Alpha, Kleinberg  
Entropy, Laplacian, Harmonic, Semi-local, Local Bridging, Leverage, and Dangalchev Closeness  

The node with the highest centrality across these metrics was identified as the most critical station.  

---

## 📊 Results & Discussion

- The Indian Railway Network exhibits exponential degree distribution, showing that a few major stations dominate traffic flow.
- NDLS (New Delhi Station) emerged as the most central node, ranking highest in 9 of the 15 centrality measures.
- The results indicate strong interconnections among high-degree nodes, leading to congestion along key trunk routes.
- The analysis supports policy-level improvements in under-connected regions and strategic expansion for decongesting busy routes.

---

## 📉 Limitations

- Dataset limited to 1000 records for feasibility.
- Network not fully connected — larger datasets may yield more accurate results.
- Temporal dynamics of train schedules not considered.

---

## 🧩 Future Enhancements

- Extend dataset to include all IRN stations.
- Perform temporal analysis on train schedules.
- Visualize dynamic congestion and passenger flow using Shiny dashboards.
- Integrate GIS data for spatial visualization of railway routes.
