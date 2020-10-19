"""Script to download the rendered dataset."""

from google_drive_downloader import GoogleDriveDownloader as gdd
import zipfile
import shutil

from chesscog.utils.io import URI

render_dir = URI("data://render")
zip_file = URI("data://render.zip")
print("Downloading dataset...")
gdd.download_file_from_google_drive(file_id="1XClmGJwEWNcIkwaH0VLuvvAY3qk_CRJh",
                                    dest_path=zip_file,
                                    overwrite=True,
                                    showsize=True)

print("Unzipping dataset...")
shutil.rmtree(render_dir, ignore_errors=True)
with zipfile.ZipFile(zip_file, "r") as f:
    f.extractall(path=render_dir.parent)

print(f"Downloaded dataset to {render_dir}.")