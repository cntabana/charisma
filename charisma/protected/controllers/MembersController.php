<?php

class MembersController extends GxController {

public function filters() {
	return array(
			'accessControl', 
			);
}

public function accessRules() {
	return array(

		 array('allow', 
				'actions'=>array('admin', 'view','GenerateExcel','GeneratePdf','admin','UpdateBooster','lunette','formulaire','ordonnanceMedicale','analyseDemande'),
				'expression'=>'$user->groupe == 1 || $user->groupe == 2 || $user->groupe == 4 || $user->groupe == 5',
				),
		array('allow', 
				'actions'=>array('admin', 'view','minicreate', 'index','create', 'update',  'delete','UpdateBooster','lunette','formulaire','ordonnanceMedicale','analyseDemande'),
				'expression'=>'$user->groupe == 4 || $user->groupe == 5',
				),
			array('deny', 
				'users'=>array('*'),
				),
			);
}

	public function actionView($id) {
		$this->render('view', array(
			'model' => $this->loadModel($id, 'Members'),
		));
	}

	public function actionCreate() {
		$model = new Members;

 		if (isset($_POST['Members'])) {
            /* ------------------------- Image code --------------------------------------- */

           $rnd = rand(0,9999);  // generate random number between 0-9999
           $model->setAttributes($_POST['Members']); //is always in action create
 
            $uploadedFile=CUploadedFile::getInstance($model,'photo');
           
           if(empty($uploadedFile)){
			$fileName = 'default.jpg';
			$model->photo = $fileName;
			}
			else{
            $fileName = "{$rnd}-{$uploadedFile}";  // random number + file name
            $model->photo = $fileName;
            }

          /* ------------------------- End Image code --------------------------------------- */

			

			if ($model->save()) {

              if($fileName != 'default.jpg')
				$uploadedFile->saveAs(Yii::app()->basePath.'/../pictures/'.$fileName);  // image 
				if (Yii::app()->getRequest()->getIsAjaxRequest())
					Yii::app()->end();
				else
					$this->redirect(array('view', 'id' => $model->id));
			}
		}

		$this->render('create', array( 'model' => $model));
	}

	public function actionUpdate($id) {
		$model = $this->loadModel($id, 'Members');
        

		if (isset($_POST['Members'])) {
			$_POST['Members']['photo'] = $model->photo;

			$model->setAttributes($_POST['Members']);
            $uploadedFile=CUploadedFile::getInstance($model,'photo');
			if ($model->save()) {
				
				 if(!empty($uploadedFile))  // check if uploaded file is set or not
                  {
                       $uploadedFile->saveAs(Yii::app()->basePath.'/../pictures/'.$model->photo);
                  }
				$this->redirect(array('view', 'id' => $model->id));
			}
		}

		$this->render('update', array(
				'model' => $model,
				));
	}

	public function actionDelete($id) {
		if (Yii::app()->getRequest()->getIsPostRequest()) {
			$this->loadModel($id, 'Members')->delete();

			if (!Yii::app()->getRequest()->getIsAjaxRequest())
				$this->redirect(array('admin'));
		} else
			throw new CHttpException(400, Yii::t('app', 'Your request is invalid.'));
	}

	public function actionIndex() {
		$dataProvider = new CActiveDataProvider('Members');
		$this->render('index', array(
			'dataProvider' => $dataProvider,
		));
	}

	public function actionAdmin() {
		$model = new Members('search');
		$model->unsetAttributes();

		if (isset($_GET['Members']))
			$model->setAttributes($_GET['Members']);

		$this->render('admin', array(
			'model' => $model,
		));
	}
	  public function actionGenerateExcel() 
	{
            $session=new CHttpSession;
            $session->open();		
            
             if(isset($session['Members_records']))
               {
                $model=$session['Members_records'];
               }
               else
                 $model = Members::model()->findAll();

		
		Yii::app()->request->sendFile(date('YmdHis').'.xls',
			$this->renderPartial('excelReport', array(
				'model'=>$model
			), true)
		);
	}
        public function actionGeneratePdf() 
	{
           $session=new CHttpSession;
           $session->open();
		Yii::import('application.modules.admin.extensions.giiplus.bootstrap.*');
		require_once('tcpdf/tcpdf.php');
		require_once('tcpdf/config/lang/eng.php');

             if(isset($session['Members_records']))
               {
                $model=$session['Members_records'];
               }
               else
                 $model = Members::model()->findAll();



		$html = $this->renderPartial('expenseGridtoReport', array(
			'model'=>$model
		), true);
		
		//die($html);
		
		$pdf = new TCPDF();
		$pdf->SetCreator(PDF_CREATOR);
		$pdf->SetAuthor(Yii::app()->name);
		$pdf->SetTitle('Members Report');
		$pdf->SetSubject('Members Report');
		//$pdf->SetKeywords('example, text, report');
		$pdf->SetHeaderData('', 0, "Report", '');
		$pdf->SetHeaderData(PDF_HEADER_LOGO, PDF_HEADER_LOGO_WIDTH, "Report by ".Yii::app()->name, "");
		$pdf->setHeaderFont(Array('helvetica', '', 8));
		$pdf->setFooterFont(Array('helvetica', '', 6));
		$pdf->SetMargins(15, 18, 15);
		$pdf->SetHeaderMargin(5);
		$pdf->SetFooterMargin(10);
		$pdf->SetAutoPageBreak(TRUE, 0);
		$pdf->SetFont('dejavusans', '', 7);
		$pdf->AddPage();
		$pdf->writeHTML($html, true, false, true, false, '');
		$pdf->LastPage();
		$pdf->Output("Members_002.pdf", "I");
	}


public function actionUpdateBooster()
	{
		    $es = new EditableSaver('Members');
			$es->update();
	}



public function actionFormulaire($id) {

	$criteria=new CDbCriteria(array('condition'=>'id='.$id));

    $dataProvider = new CActiveDataProvider('Members', array(
            'criteria'=>$criteria,
    ));
		$this->render('formulaire', array(
			'dataProvider' => $dataProvider,
		));

		
	}

public function actionOrdonnanceMedicale($id) {

	$criteria=new CDbCriteria(array('condition'=>'id='.$id));

    $dataProvider = new CActiveDataProvider('Members', array(
            'criteria'=>$criteria,
    ));
		$this->render('ordonnanceMedicale', array(
			'dataProvider' => $dataProvider,
		));

		
	}

	public function actionAnalyseDemande($id) {

	$criteria=new CDbCriteria(array('condition'=>'id='.$id));

    $dataProvider = new CActiveDataProvider('Members', array(
            'criteria'=>$criteria,
    ));
		$this->render('analyseDemande', array(
			'dataProvider' => $dataProvider,
		));

		
	}

	public function actionLunette($id) {

	$criteria=new CDbCriteria(array('condition'=>'id='.$id));

    $dataProvider = new CActiveDataProvider('Members', array(
            'criteria'=>$criteria,
    ));
		$this->render('lunette', array(
			'dataProvider' => $dataProvider,
		));

		
	}
}