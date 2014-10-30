<?php

class MembersBootController extends CController
{
        public $breadcrumbs;
	/**
	 * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
	 * using two-column layout. See 'protected/views/layouts/column2.php'.
	 */
	public $layout='main';

	/**
	 * @return array action filters
	 */
	public function filters()
	{
		return array(
			'accessControl', // perform access control for CRUD operations
		);
	}

	/**
	 * Specifies the access control rules.
	 * This method is used by the 'accessControl' filter.
	 * @return array access control rules
	 */
	public function accessRules()
	{
		return array(
			array('allow',  // allow all users to perform 'index' and 'view' actions
				'actions'=>array('index','view'),
				'users'=>array('*'),
			),
			array('allow', // allow authenticated user to perform 'create' and 'update' actions
				'actions'=>array('create','update','GeneratePdf','GenerateExcel'),
				'users'=>array('*'),
			),
			array('allow', // allow admin user to perform 'admin' and 'delete' actions
				'actions'=>array('admin','delete'),
				'users'=>array('*'),
			),
			array('deny',  // deny all users
				'users'=>array('*'),
			),
		);
	}

	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionView($id)
	{
		$this->render('view',array(
			'model'=>$this->loadModel($id),
		));
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionCreate()
	{
		$model=new MembersBoot;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['MembersBoot']))
		{
			$model->attributes=$_POST['MembersBoot'];
			if($model->save())
				$this->redirect(array('view','id'=>$model->id));
		}

		$this->render('create',array(
			'model'=>$model,
		));
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionUpdate($id)
	{
		$model=$this->loadModel($id);

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['MembersBoot']))
		{
			$model->attributes=$_POST['MembersBoot'];
			if($model->save())
				$this->redirect(array('view','id'=>$model->id));
		}

		$this->render('update',array(
			'model'=>$model,
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDelete($id)
	{
		if(Yii::app()->request->isPostRequest)
		{
			// we only allow deletion via POST request
			$this->loadModel($id)->delete();

			// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
			if(!isset($_GET['ajax']))
				$this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
		}
		else
			throw new CHttpException(400,'Invalid request. Please do not repeat this request again.');
	}

	/**
	 * Lists all models.
	 */
	public function actionIndex()
	{
            $session=new CHttpSession;
            $session->open();		
            $criteria = new CDbCriteria();            

                $model=new MembersBoot('search');
                $model->unsetAttributes();  // clear any default values

                if(isset($_GET['MembersBoot']))
		{
                        $model->attributes=$_GET['MembersBoot'];
			
			
                   	
                       if (!empty($model->id)) $criteria->addCondition('id = "'.$model->id.'"');
                     
                    	
                       if (!empty($model->cardnumber)) $criteria->addCondition('cardnumber = "'.$model->cardnumber.'"');
                     
                    	
                       if (!empty($model->firstname)) $criteria->addCondition('firstname = "'.$model->firstname.'"');
                     
                    	
                       if (!empty($model->middlename)) $criteria->addCondition('middlename = "'.$model->middlename.'"');
                     
                    	
                       if (!empty($model->lastname)) $criteria->addCondition('lastname = "'.$model->lastname.'"');
                     
                    	
                       if (!empty($model->issuedate)) $criteria->addCondition('issuedate = "'.$model->issuedate.'"');
                     
                    	
                       if (!empty($model->expireddate)) $criteria->addCondition('expireddate = "'.$model->expireddate.'"');
                     
                    	
                       if (!empty($model->birthday)) $criteria->addCondition('birthday = "'.$model->birthday.'"');
                     
                    	
                       if (!empty($model->sex)) $criteria->addCondition('sex = "'.$model->sex.'"');
                     
                    	
                       if (!empty($model->phonenumber)) $criteria->addCondition('phonenumber = "'.$model->phonenumber.'"');
                     
                    	
                       if (!empty($model->address)) $criteria->addCondition('address = "'.$model->address.'"');
                     
                    	
                       if (!empty($model->email)) $criteria->addCondition('email = "'.$model->email.'"');
                     
                    	
                       if (!empty($model->iddistrict)) $criteria->addCondition('iddistrict = "'.$model->iddistrict.'"');
                     
                    	
                       if (!empty($model->idsector)) $criteria->addCondition('idsector = "'.$model->idsector.'"');
                     
                    	
                       if (!empty($model->nationality)) $criteria->addCondition('nationality = "'.$model->nationality.'"');
                     
                    	
                       if (!empty($model->status)) $criteria->addCondition('status = "'.$model->status.'"');
                     
                    	
                       if (!empty($model->type)) $criteria->addCondition('type = "'.$model->type.'"');
                     
                    	
                       if (!empty($model->photo)) $criteria->addCondition('photo = "'.$model->photo.'"');
                     
                    	
                       if (!empty($model->title)) $criteria->addCondition('title = "'.$model->title.'"');
                     
                    			
		}
                 $session['MembersBoot_records']=MembersBoot::model()->findAll($criteria); 
       

                $this->render('index',array(
			'model'=>$model,
		));

	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new MembersBoot('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['MembersBoot']))
			$model->attributes=$_GET['MembersBoot'];

		$this->render('admin',array(
			'model'=>$model,
		));
	}

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer the ID of the model to be loaded
	 */
	public function loadModel($id)
	{
		$model=MembersBoot::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param CModel the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='members-boot-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
        public function actionGenerateExcel()
	{
            $session=new CHttpSession;
            $session->open();		
            
             if(isset($session['MembersBoot_records']))
               {
                $model=$session['MembersBoot_records'];
               }
               else
                 $model = MembersBoot::model()->findAll();

		
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

             if(isset($session['MembersBoot_records']))
               {
                $model=$session['MembersBoot_records'];
               }
               else
                 $model = MembersBoot::model()->findAll();



		$html = $this->renderPartial('expenseGridtoReport', array(
			'model'=>$model
		), true);
		
		//die($html);
		
		$pdf = new TCPDF();
		$pdf->SetCreator(PDF_CREATOR);
		$pdf->SetAuthor(Yii::app()->name);
		$pdf->SetTitle('MembersBoot Report');
		$pdf->SetSubject('MembersBoot Report');
		//$pdf->SetKeywords('example, text, report');
		$pdf->SetHeaderData('', 0, "Report", '');
		$pdf->SetHeaderData(PDF_HEADER_LOGO, PDF_HEADER_LOGO_WIDTH, "Example Report by ".Yii::app()->name, "");
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
		$pdf->Output("MembersBoot_002.pdf", "I");
	}
}
