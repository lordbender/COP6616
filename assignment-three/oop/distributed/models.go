package distributed

// VectorModel is used by server.go and matrix.go as a
// contract between client and server.
type VectorModel struct {
	RowIndex int
	Vector   []int
}

// MergeRequestModel is used by server.go and sorting.go as a
// contract between client and server.
type MergeRequestModel struct {
	Left  []int
	Right []int
}

// MergeResponseModel is used by server.go and sorting.go as a
// contract between client and server.
type MergeResponseModel struct {
	Merged []int
}
