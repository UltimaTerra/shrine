package eco

import "core:fmt"

Data_Value :: union($val: typeid) {}
Data :: struct($T, $K: typeid) {}
DataBase :: struct($D, $B: typeid) {
	dBuffer: Data_Value,
	dUnit:   Data,
}


///

ecodb_init :: proc() {

}
ecodb_crud :: proc() {

}
ecodb_cli :: proc() {

}
ecodb_iniffmt :: proc() {

}
