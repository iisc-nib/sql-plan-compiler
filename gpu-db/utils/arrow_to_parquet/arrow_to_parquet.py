import argparse
import pyarrow.parquet as pq
import pyarrow as pa
 
def convert_arrow_to_parquet(arrow_file_path, parquet_file_path):
    """
    Reads an Arrow file and saves it as a Parquet file.
 
    Args:
        arrow_file_path (str): Path to the input Arrow file.
        parquet_file_path (str): Path to save the output Parquet file.
    """
    try:
        # Read the Arrow file
        table = pa.ipc.open_file(arrow_file_path).read_all()
 
        # Write the table to a Parquet file
        pq.write_table(table, parquet_file_path)
 
        print(f"Successfully converted '{arrow_file_path}' to '{parquet_file_path}'")
 
    except Exception as e:
         print(f"An error occurred: {e}")
 
if __name__ == "__main__":
    argparser = argparse.ArgumentParser(description="Convert Arrow files to Parquet format.")

    argparser.add_argument("--data_dir", type=str, default="ssb-10/", required=True)

    args = argparser.parse_args()

    # find all files in the data_dir that match "*.arrow"
    import glob
    import os
    arrow_files = glob.glob(os.path.join(args.data_dir, "*.arrow"))
    # Convert each Arrow file to Parquet
    for arrow_file in arrow_files:
        # Construct the Parquet file name by replacing the .arrow extension with .parquet
        parquet_file = arrow_file.replace(".arrow", ".parquet")
        # Convert the file
        print(f"Converting {arrow_file} to {parquet_file}...")
        convert_arrow_to_parquet(arrow_file, parquet_file)