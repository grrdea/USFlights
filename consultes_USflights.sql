# 1.Quantitat de registres de la taula de vols:
SELECT COUNT(*) FROM Flights;

# 2.Retard promig de sortida i arribada segons l’aeroport origen.
SELECT Origin,AVG(ArrDelay),AVG(DepDelay) 
FROM Flights GROUP BY Origin;

# 3.Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen.
SELECT Origin,colYear AS Year,colMonth AS Month,AVG(ArrDelay) AS "Arrivals Average"
FROM Flights GROUP BY Origin,colYear,colMonth ORDER BY Origin,colYear;

# 4.Mateixa consulta que abans i amb el mateix ordre. Però a més, en comptes del codi de l’aeroport es mostra	 el nom de la ciutat.
SELECT City,
	   colYear AS Year,colMonth AS Month,AVG(ArrDelay) AS "Arrivals Average"
FROM Flights
LEFT JOIN USAirports
ON Flights.Origin=USAirports.IATA
GROUP BY City,colYear,colMonth ORDER BY City,colYear,colMonth;

# 5.Les companyies amb més vols cancelats, per mesos i any. A més, han d’estar ordenades de forma que les companyies amb més cancel·lacions apareguin les primeres.
SELECT UniqueCarrier,colYear AS Year,colMonth AS Month,AVG(ArrDelay) AS "Arrivals Average", SUM(Cancelled) AS Cancelled
FROM Flights
GROUP BY UniqueCarrier,colYear,colMonth 
HAVING COUNT(Cancelled>0)
ORDER BY Cancelled DESC;


# 6.L’identificador dels 10 avions que més distància han recorregut fent vols.
SELECT TailNum, SUM(Distance) AS totalDistance
FROM Flights
WHERE TailNum!=''
GROUP BY TailNum
ORDER BY totalDistance DESC
LIMIT 10;


# 7.Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben al seu destí amb un retràs promig major de 10 minuts. 
SELECT UniqueCarrier, AVG(ArrDelay) AS AvgDelay
FROM Carriers
LEFT JOIN Flights
ON Carriers.CarrierCode=Flights.UniqueCarrier
GROUP BY UniqueCarrier
HAVING AvgDelay > 10
ORDER BY AvgDelay DESC;
