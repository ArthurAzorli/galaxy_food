package br.ind.galaxyfood.galaxy_food

import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.ImageDecoder
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import java.io.OutputStream


class MainActivity: FlutterActivity(), MethodChannel.MethodCallHandler{

    private lateinit var resultMain: MethodChannel.Result

    private var aspectRadioX: Int? = null
    private var aspectRadioY: Int? = null
    private var height: Double? = null
    private var width: Double? = null

    private var intermediateName: String = "1.jpg"
    private var resultName: String = "2.jpg"

    private var intermediateProvider: Uri? = null
    private var resultProvider: Uri? = null

    companion object{
        const val TAG_IMAGE_PICKER: String = "IMAGE PICKER"
        private const val IMAGE_PICKER_METHOD = "galaxy_food.native.widget/image_picker"
        private const val CAMERA_CODE = 1
        private const val GALLERY_CODE = 2
        private const val CROP_CODE = 3
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, IMAGE_PICKER_METHOD)
            .setMethodCallHandler(this)

    }


    //Image Picker Method

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.d(TAG_IMAGE_PICKER, "Start Launch")

        resultMain = result
        aspectRadioX = call.argument("aspectX")
        aspectRadioY = call.argument("aspectY")
        height = call.argument("height")
        width = call.argument("width")

        when (call.method){

            "getFromCamera" -> onLaunchCamera()

            "getFromGallery" -> onPickPhoto()

            "getProvider" -> onProvider()

        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        Log.d(TAG_IMAGE_PICKER, "Receive Activity Result")

        if (resultCode == RESULT_OK && requestCode == CAMERA_CODE){
            loadFromUri(intermediateProvider)
            onCropImage()
        } else if (resultCode == RESULT_OK && requestCode == GALLERY_CODE && data != null) {
            saveBitmapFileToIntermediate(data.data!!)
            loadFromUri(intermediateProvider)
            onCropImage()
        } else if (resultCode == RESULT_OK && requestCode == CROP_CODE) {
            resultMain.success(loadFromUri(resultProvider)?.toByteArray())
        }
    }

    private fun onLaunchCamera() {
        val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
        val photoFile = getPhotoFileUri(intermediateName)
        intermediateProvider = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N)
            FileProvider.getUriForFile(
            this, "br.ind.galaxyfood.image_provider", photoFile
            )
        else Uri.fromFile(photoFile)
        intent.putExtra(MediaStore.EXTRA_OUTPUT, intermediateProvider)
        if (intent.resolveActivity(this.packageManager) != null) {
            startActivityForResult(intent, CAMERA_CODE)
            Log.d(TAG_IMAGE_PICKER, "Launch Camera")
        }
    }

    private fun onPickPhoto() {
        val intent = Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
        if (intent.resolveActivity(this.packageManager) != null) {
            startActivityForResult(intent, GALLERY_CODE)
            Log.d(TAG_IMAGE_PICKER, "Launch Gallery")
        }
    }

    private fun onCropImage() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            this.grantUriPermission(
                "com.android.camera",
                intermediateProvider,
                Intent.FLAG_GRANT_WRITE_URI_PERMISSION or Intent.FLAG_GRANT_READ_URI_PERMISSION
            )
            val intent = Intent("com.android.camera.action.CROP")
            intent.setDataAndType(intermediateProvider, "image/*")

            val list = this.packageManager.queryIntentActivities(intent, PackageManager.MATCH_DEFAULT_ONLY)

            list.forEach{
                this.grantUriPermission(
                    it.activityInfo.packageName,
                    intermediateProvider,
                    Intent.FLAG_GRANT_WRITE_URI_PERMISSION or Intent.FLAG_GRANT_READ_URI_PERMISSION
                )
            }

            val size = list.size

            if (size == 0) {
                Log.e(TAG_IMAGE_PICKER, "Error, wasn't taken image!")
                resultMain.error(TAG_IMAGE_PICKER, "Error, wasn't taken image!", null)
            } else {
                intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                intent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION)
                intent.putExtra("crop", "true")
                intent.putExtra("aspectX", aspectRadioX)
                intent.putExtra("aspectY", aspectRadioY)
                intent.putExtra("outputX", width)
                intent.putExtra("outputY", height)
                intent.putExtra("scale", true)

                val photoFile = getPhotoFileUri(resultName)

                resultProvider = FileProvider.getUriForFile(
                    this,
                    "br.ind.galaxyfood.image_provider",
                    photoFile
                )

                intent.putExtra("return-data", false)
                intent.putExtra(MediaStore.EXTRA_OUTPUT, resultProvider)
                intent.putExtra("outputFormat", Bitmap.CompressFormat.JPEG.toString())

                val cropIntent = Intent(intent)

                cropIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                cropIntent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION)
                list.forEach{
                    this.grantUriPermission(
                        it.activityInfo.packageName,
                        resultProvider,
                        Intent.FLAG_GRANT_WRITE_URI_PERMISSION or Intent.FLAG_GRANT_READ_URI_PERMISSION
                    )
                }

                Log.d(TAG_IMAGE_PICKER, "Launch Cropper")

                startActivityForResult(cropIntent, CROP_CODE)
            }
        } else {
            val photoFile = getPhotoFileUri(resultName)
            resultProvider = Uri.fromFile(photoFile)

            val intentCrop = Intent("com.android.camera.action.CROP")
            intentCrop.setFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION)
            intentCrop.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            intentCrop.setDataAndType(intermediateProvider, "image/*")
            intentCrop.putExtra("crop", "true")
            intentCrop.putExtra("scale", true)
            intentCrop.putExtra("outputFormat", Bitmap.CompressFormat.JPEG.toString())
            intentCrop.putExtra("noFaceDetection", true)
            intentCrop.putExtra("return-data", false)
            intentCrop.putExtra("aspectX", aspectRadioX)
            intentCrop.putExtra("aspectY", aspectRadioY)
            intentCrop.putExtra("outputX", width)
            intentCrop.putExtra("outputY", height)
            intentCrop.putExtra(MediaStore.EXTRA_OUTPUT, resultProvider)

            Log.d(TAG_IMAGE_PICKER, "Launch Cropper")

            startActivityForResult(intentCrop, CROP_CODE)
        }
    }

    private fun onProvider(){
        val image = loadFromUri(resultProvider)

        if (image == null){
            resultMain.error("404", "Image not selected previously", null)
            return
        }
        resultMain.success(image.toByteArray())
    }

    private fun getPhotoFileUri(fileName: String): File {
        val mediaStorageDir = File(this.getExternalFilesDir(""), "crop")
        if (!mediaStorageDir.exists() && !mediaStorageDir.mkdirs()) {
            Log.d(TAG_IMAGE_PICKER, "failed to create directory")
        }
        val file = File(mediaStorageDir.path + File.separator + fileName)
        return file
    }

    private fun loadFromUri(photoUri: Uri?): Bitmap? {
        var image: Bitmap? = null
        try {
            if (Build.VERSION.SDK_INT > Build.VERSION_CODES.O_MR1) {
                // on newer versions of Android, use the new decodeBitmap method
                val source = ImageDecoder.createSource(
                    this.contentResolver,
                    photoUri!!
                )
                image = ImageDecoder.decodeBitmap(source)
            } else {
                // support older versions of Android by using getBitmap
                image = MediaStore.Images.Media.getBitmap(this.contentResolver, photoUri)
            }
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return image
    }

    private fun saveBitmapFileToIntermediate(sourceUri: Uri) {
        try {
            val bitmap = loadFromUri(sourceUri)

            val imageFile = getPhotoFileUri(intermediateName)
            intermediateProvider = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N)
                FileProvider.getUriForFile(
                this, "br.ind.galaxyfood.image_provider", imageFile
                )
            else Uri.fromFile(imageFile)

            val out: OutputStream = FileOutputStream(imageFile)
            bitmap!!.compress(Bitmap.CompressFormat.JPEG, 100, out)
            out.close()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun Bitmap.toByteArray(): ByteArray {
        val stream = ByteArrayOutputStream()
        this.compress(Bitmap.CompressFormat.JPEG, 100, stream)
        return stream.toByteArray()
    }

}