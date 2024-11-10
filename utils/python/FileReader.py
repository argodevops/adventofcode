class FileReader:
    def __init__(self, file_path):
        self.file_path = file_path

    def read_lines(self):
        try:
            with open(self.file_path, 'r') as file:
                lines = [line.strip() for line in file.readlines()]
            return lines
        except FileNotFoundError:
            print(f"Error: The file '{self.file_path}' was not found.")
            return []
        except IOError:
            print(f"Error: An error occurred while reading the file '{self.file_path}'.")
            return []
