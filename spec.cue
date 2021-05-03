package spec

version: 2
sources: [...#Source]


#StringInt: string | number

#Partition: {
	name:        string & !=""
	data_type:   string & !=""
	expression?: string
	vals?: {
		macro: string & !=""
		args: [string]: #StringInt
	}
	path_macro?: string & !=""
}

#SourceSnowflake: {
	location:     string & !=""
	file_format:  string & !=""
	auto_refresh: bool
	partitions: [...#Partition]
}

#SourceRedshift: {
	location:   string & !=""
	row_format: string & !=""
	partitions: [...#Partition]
}

#SourceSpark: {
	location: string & !=""
	using:    string & !=""
	options: [string]: string
}

#Column: {
	name:         string & !=""
	data_type:    string & !=""
	description?: string
}

#Table: {
	name:     string & !=""
	external: #SourceRedshift | #SourceSnowflake | #SourceSpark
	table_properties: [string]: string
	columns: [...#Column]
}

#Loaders: "S3"

#Source: {
	name:             string & !=""
	database?:        string & !=""
	schema?:          string & !=""
	loader:           #Loaders
	loaded_at_field?: string & !=""
	tables: [...#Table]
}
