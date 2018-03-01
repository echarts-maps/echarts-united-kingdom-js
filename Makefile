all: uk ir merge js


uk:
	ogr2ogr -f GeoJSON -t_srs EPSG:4326 Westminster_Parliamentary_Constituencies_December_2016_Full_Clipped_Boundaries_in_the_UK.geojson src/Westminster_Parliamentary_Constituencies_December_2016_Full_Clipped_Boundaries_in_the_UK/Westminster_Parliamentary_Constituencies_December_2016_Full_Clipped_Boundaries_in_the_UK.shp
	node ./node_modules/.bin/property -r pcon16cd,name Westminster_Parliamentary_Constituencies_December_2016_Full_Clipped_Boundaries_in_the_UK.geojson

ir:
	ogr2ogr -f GeoJSON -where "ADM0_A3 IN ('IRL')" irland.geojson src/ne_10m_admin_0_sovereignty/ne_10m_admin_0_sovereignty.shp
	node ./node_modules/.bin/property -r SOVEREIGNT,name irland.geojson

merge: uk ir
	node ./node_modules/.bin/merge Westminster_Parliamentary_Constituencies_December_2016_Full_Clipped_Boundaries_in_the_UK.geojson irland.geojson

js: merge
	node ./node_modules/.bin/makejs merged_Westminster_Parliamentary_Constituencies_December_2016_Full_Clipped_Boundaries_in_the_UK.geojson echarts-united-kingdom-js/westminster_2016_uk.js UK_electoral_2016

.PHONY: clean

clean:
	rm merged_Westminster_Parliamentary_Constituencies_December_2016_Full_Clipped_Boundaries_in_the_UK.geojson
	rm Westminster_Parliamentary_Constituencies_December_2016_Full_Clipped_Boundaries_in_the_UK.geojson
	rm irland.geojson
