<?php

$this->breadcrumbs = array(
	$model->label(2) => array('index'),
	GxHtml::valueEx($model),
);

$this->menu=array(
	array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('index')),
	array('label'=>Yii::t('app', 'Create') . ' ' . $model->label(), 'url'=>array('create')),
	array('label'=>Yii::t('app', 'Update') . ' ' . $model->label(), 'url'=>array('update', 'id' => $model->id)),
	array('label'=>Yii::t('app', 'Delete') . ' ' . $model->label(), 'url'=>'#', 'linkOptions' => array('submit' => array('delete', 'id' => $model->id), 'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>Yii::t('app', 'Manage') . ' ' . $model->label(2), 'url'=>array('admin')),
);
?>

<h3><?php echo Yii::t('app', 'View') . ' ' . GxHtml::encode($model->label()) . ' ' . GxHtml::encode(GxHtml::valueEx($model)); ?></h3>
<hr>
<?php 
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('admin'), 'linkOptions'=>array()),
		array('label'=>'Manage', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'),'visible'=>Yii::app()->user->groupe!=1 && Yii::app()->user->groupe!=2,'active'=>true, 'linkOptions'=>array()),
		array('label'=>'Formulaire des sois du patient', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/formulaire',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2 ,'linkOptions'=>array()),
        array('label'=>'Ordonnance Medicale', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/ordonnanceMedicale',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
        array('label'=>'Medical spectacle prescription', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/lunette',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
        array('label'=>'Bullettin d\'analyse', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/analyseDemande',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
        array('label'=>'Print', 'icon'=>'icon-print', 'url'=>'javascript:void(0);return false', 'linkOptions'=>array('onclick'=>'printDiv();return false;')),

		),
));
$this->endWidget();
?>
</hr>
<?php $this->widget('zii.widgets.CDetailView', array(
	'data' => $model,
	'attributes' => array(
 array(        
        'name'=>'photo',
        'type'  => 'raw',
         'value'=> CHtml::image(Yii::app()->request->baseUrl.'/pictures/'.$model->photo,"photo",array("width"=>200)),
     ),

'cardnumber',
'title',
'firstname',
'lastname',
'middlename',
array(
           'name'=>'status',
           'type'=>'raw',
           'value'=>(CHtml::encode($model->status)== 0)? "<span class=\"label label-important\">Inactive</span>":"<span class=\"label label-success\">Active</span>",
        ),
'nationality',
'birthday',
array(
           'name'=>'sex',
           'type'=>'raw',
           'value'=>(CHtml::encode($model->sex)== 0)? "<span >Male</span>":"<span >Female</span>",
        ),
array(
			'name' => 'iddistrict0',
			'type' => 'raw',
			'value' => $model->iddistrict0 !== null ? GxHtml::link(GxHtml::encode(GxHtml::valueEx($model->iddistrict0)), array('district/view', 'id' => GxActiveRecord::extractPkValue($model->iddistrict0, true))) : null,
			),
array(
			'name' => 'idsector0',
			'type' => 'raw',
			'value' => $model->idsector0 !== null ? GxHtml::link(GxHtml::encode(GxHtml::valueEx($model->idsector0)), array('sector/view', 'id' => GxActiveRecord::extractPkValue($model->idsector0, true))) : null,
			),
'phonenumber',
'email',
'address',
'issuedate',
'expireddate',

array(
           'name'=>'type',
           'type'=>'raw',
           'value'=>(CHtml::encode($model->type)== 0)? "<span>Student</span>":"<span>Teacher</span>",
        ),
	),
)); ?>
<table width='100%'>
	<tr>
		<td valign='top' width='50%'>
<h3><?php echo GxHtml::encode($model->getRelationLabel('beneficaires')); ?></h3>
<?php
	foreach ($model->beneficaires as $relatedModel);



	$count=Yii::app()->db->createCommand('SELECT COUNT(*) FROM  beneficaire where idmember='.$_GET['id'])->queryScalar();
    $sql='select id,firstname,lastname surnames,Dateofbirth,sex Gender,type from beneficaire where idmember='.$_GET['id'];
   
    $dataProvider=new CSqlDataProvider($sql, array(
    'totalItemCount'=>$count,
    	'keyField'=>'id',
    'sort'=>array(
        'attributes'=>array(
              'firstname','lastname','Dateofbirth','sex','type'
        ),
    ),
    'pagination'=>array(
        'pageSize'=>10,
    ),
));


	 $this->widget('zii.widgets.grid.CGridView', array(

	//'id' => 'id',
	'dataProvider' => $dataProvider,
	//'filter' => $model,
	'columns' => array(
	     'id',
		'firstname',
		'Surnames',
		'Dateofbirth',
		'Gender',
		'type',
				array(
			'class'=>'CButtonColumn',
			'template' =>'{view}',
			'buttons'=>array(
            'view'=>array(
                             'url'=>'Yii::app()->controller->createUrl("beneficaire/view",array("id" =>$data["id"] ))',
							  'imageUrl'=>'../charisma/images/view.png',
			),
				
	),
	),
	),
)); 
?>
</td>
<td valign='top' width='50%'>
<h3><?php echo GxHtml::encode($model->getRelationLabel('invoices')); ?></h3>
<?php

    $count=Yii::app()->db->createCommand('SELECT COUNT(*) FROM invoice where idmember='.$_GET['id'])->queryScalar();
    $sql='SELECT * FROM invoice where idmember='.$_GET['id'];
   
    $dataProvider=new CSqlDataProvider($sql, array(
    'totalItemCount'=>$count,
    'sort'=>array(
        'attributes'=>array(
             'id', 'date', 'type',
        ),
    ),
    'pagination'=>array(
        'pageSize'=>10,
    ),
));


	 $this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'invoice-grid',
	'dataProvider' => $dataProvider,
	//'filter' => $model,
	'columns' => array(
		'id',
		'type',
		'date',
		/*array(
				'name'=>'idmember',
				'value'=>'GxHtml::valueEx($data->idmember0)',
				//'filter'=>GxHtml::listDataEx(Members::model()->findAllAttributes(null, true)),
				),
		array(
        'name'=>'type',
        'value'=>'Traitement::getType($data->type)',
        'filter'=>CHtml::listData(Traitement::getTypes(), 'id', 'type'),
        ),
		array(
				'name'=>'idhospital',
				'value'=>'GxHtml::valueEx($data->idhospital0)',
				'filter'=>GxHtml::listDataEx(Hospital::model()->findAllAttributes(null, true)),
				),
		'date',
		'status',
		array(
			'class' => 'CButtonColumn',
		),
*/
	),
)); 
?>
</td>
</tr>
</table>